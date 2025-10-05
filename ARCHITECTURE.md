# AI Trader - Technical Architecture

## Overview

AI Trader is a sophisticated Expert Advisor (EA) for MetaTrader 5 that implements a neural network-based trading system with adaptive learning capabilities. This document describes the technical architecture and implementation details.

## System Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                     MetaTrader 5 Platform                    │
├─────────────────────────────────────────────────────────────┤
│                                                               │
│  ┌───────────────────────────────────────────────────────┐  │
│  │              AI Trader Expert Advisor                  │  │
│  ├───────────────────────────────────────────────────────┤  │
│  │                                                         │  │
│  │  ┌──────────────┐  ┌──────────────┐  ┌─────────────┐ │  │
│  │  │  Data Layer  │  │   AI Layer   │  │ Trade Layer │ │  │
│  │  └──────────────┘  └──────────────┘  └─────────────┘ │  │
│  │         │                  │                  │        │  │
│  │         ▼                  ▼                  ▼        │  │
│  │  ┌──────────────┐  ┌──────────────┐  ┌─────────────┐ │  │
│  │  │ Indicators   │  │Neural Network│  │Risk Manager │ │  │
│  │  │  - RSI       │  │  - Forward   │  │ - Position  │ │  │
│  │  │  - MACD      │  │  - Backprop  │  │   Sizing    │ │  │
│  │  │  - Bollinger │  │  - Activation│  │ - Stop Loss │ │  │
│  │  │  - ATR       │  │  - Learning  │  │ - Trailing  │ │  │
│  │  └──────────────┘  └──────────────┘  └─────────────┘ │  │
│  │         │                  │                  │        │  │
│  │         └──────────────────┴──────────────────┘        │  │
│  │                            │                            │  │
│  │                            ▼                            │  │
│  │                  ┌──────────────────┐                  │  │
│  │                  │  Pattern Memory  │                  │  │
│  │                  │   & Learning     │                  │  │
│  │                  └──────────────────┘                  │  │
│  └───────────────────────────────────────────────────────┘  │
│                                                               │
└─────────────────────────────────────────────────────────────┘
```

## Core Components

### 1. Data Collection Layer

**Responsibilities**:
- Collect market data from MT5 platform
- Manage technical indicator calculations
- Normalize data for neural network input
- Handle multi-timeframe synchronization

**Implementation**:
```cpp
struct MarketPattern {
    double features[50];      // Normalized feature vector
    int signal;               // Trade signal: 1=buy, -1=sell, 0=neutral
    double confidence;        // Confidence score (0-1)
    datetime timestamp;       // Pattern timestamp
};
```

**Features Collected**:
1. Price action features (candle body, range)
2. RSI values and momentum
3. MACD main, signal, and histogram
4. Bollinger Bands position and width
5. ATR volatility measure
6. Multi-timeframe trend indicators
7. Volume patterns
8. Historical price movements

### 2. Neural Network Layer

**Architecture**:
```
Input Layer (20 neurons)
    ↓
Hidden Layer 1 (configurable: default 10)
    ↓
Hidden Layer 2 (configurable: default 10)
    ↓
Hidden Layer N (configurable: default 10)
    ↓
Output Layer (1 neuron: buy/sell signal)
```

**Activation Functions**:
- Hidden Layers: ReLU (Rectified Linear Unit)
  ```
  f(x) = max(0, x)
  ```
- Output Layer: Tanh (Hyperbolic Tangent)
  ```
  f(x) = tanh(x) = (e^x - e^-x) / (e^x + e^-x)
  ```
  Output range: -1 (strong sell) to +1 (strong buy)

**Weight Initialization**:
- Random initialization with small values (-0.05 to +0.05)
- Prevents gradient vanishing/explosion
- Seed based on local time for reproducibility

**Forward Propagation**:
```cpp
// Input to hidden layer
for(int i = 0; i < hiddenSize; i++) {
    sum = bias[i];
    for(int j = 0; j < inputSize; j++) {
        sum += input[j] * weights[j][i];
    }
    hidden[i] = ReLU(sum);
}

// Hidden to output layer
output = bias[hiddenSize];
for(int i = 0; i < hiddenSize; i++) {
    output += hidden[i] * weights[inputSize + i][0];
}
output = tanh(output);
```

### 3. Adaptive Learning System

**Learning Process**:

1. **Trade Outcome Analysis**:
   - Monitors all closed trades
   - Calculates win rate over last N trades
   - Measures profit/loss performance

2. **Weight Adjustment**:
   ```cpp
   if(winRate < 0.4) {
       // Poor performance - increase learning rate
       adjustmentRate = learningRate * 1.5;
       // Penalize weights that led to losses
       for(losing_trades) {
           weights *= (1.0 - adjustmentRate);
       }
   }
   else if(winRate > 0.6) {
       // Good performance - reinforce patterns
       for(winning_trades) {
           weights *= (1.0 + learningRate * 0.05);
       }
   }
   ```

3. **Pattern Reinforcement**:
   - Successful patterns increase related weights
   - Failed patterns decrease related weights
   - Gradual adjustment to prevent overfitting

### 4. Pattern Recognition System

**Pattern Storage**:
```cpp
struct TradeMemory {
    double entryPrice;
    double exitPrice;
    double profit;
    double confidence;
    double features[50];      // Pattern at entry
    bool wasSuccessful;
};

TradeMemory tradeHistory[MemorySize];  // Circular buffer
```

**Similarity Calculation**:
```cpp
double CalculatePatternSimilarity(pattern1, pattern2) {
    similarity = 0;
    for(each feature) {
        diff = abs(pattern1[i] - pattern2[i]);
        similarity += (1.0 - min(diff, 1.0));
    }
    return similarity / numFeatures;
}
```

**Pattern Matching**:
1. Compare current pattern with historical patterns
2. Find most similar pattern (similarity > 0.8)
3. Adjust confidence based on historical outcome:
   - If similar pattern was successful: confidence × 1.1
   - If similar pattern failed: confidence × 0.9

### 5. Signal Generation System

**Multi-Source Signal Combination**:

1. **Technical Analysis Signals**:
   ```cpp
   signalStrength = 0;
   
   // RSI component
   if(RSI < 30) signalStrength += 0.3;      // Oversold
   if(RSI > 70) signalStrength -= 0.3;      // Overbought
   
   // MACD component
   if(MACD_crossover_up) signalStrength += 0.4;
   if(MACD_crossover_down) signalStrength -= 0.4;
   
   // Bollinger Bands component
   if(price < BB_lower) signalStrength += 0.3;
   if(price > BB_upper) signalStrength -= 0.3;
   ```

2. **Neural Network Prediction**:
   ```cpp
   nnPrediction = NeuralNetworkPredict();  // -1 to +1
   nnConfidence = abs(nnPrediction);
   ```

3. **Combined Decision**:
   ```cpp
   if(nnConfidence >= ConfidenceThreshold) {
       if(nnPrediction > 0 && signalStrength > 0.3) {
           OpenTrade(BUY);
       }
       else if(nnPrediction < 0 && signalStrength < -0.3) {
           OpenTrade(SELL);
       }
   }
   ```

### 6. Risk Management System

**Position Sizing Algorithm**:

1. **Calculate Risk Amount**:
   ```cpp
   riskAmount = accountBalance * (RiskPercent / 100.0);
   ```

2. **Dynamic Adjustment**:
   ```cpp
   if(UseDynamicPositioning) {
       riskAmount *= confidence;  // Scale by AI confidence
   }
   ```

3. **Calculate Lot Size**:
   ```cpp
   stopLossDistance = ATR * StopLossATRMultiplier;
   
   if(IsCrypto) {
       stopLossDistance *= CryptoVolatilityFactor;
   }
   
   lotSize = riskAmount / (stopLossDistance / tickSize * tickValue);
   lotSize = normalize(lotSize, minLot, maxLot, lotStep);
   ```

**Stop Loss & Take Profit**:
```cpp
// ATR-based stops
stopLoss = ATR * StopLossATRMultiplier;
takeProfit = stopLoss * TakeProfitMultiplier;

// For crypto, adjust for higher volatility
if(IsCrypto) {
    stopLoss *= CryptoVolatilityFactor;
    takeProfit *= CryptoVolatilityFactor;
}
```

**Trailing Stop**:
```cpp
if(profit > 0 && UseTrailingStop) {
    trailingDistance = ATR * TrailingStopATRMultiplier;
    
    if(positionType == BUY) {
        newSL = currentPrice - trailingDistance;
        if(newSL > currentSL) {
            ModifyPosition(newSL);
        }
    }
    else if(positionType == SELL) {
        newSL = currentPrice + trailingDistance;
        if(newSL < currentSL) {
            ModifyPosition(newSL);
        }
    }
}
```

### 7. Multi-Timeframe Analysis

**Timeframe Synchronization**:
```
Primary (M15):   ████████████████████████████████
Secondary (H1):  ████████
Tertiary (H4):   ██
```

**Analysis Process**:
1. Collect indicators from all timeframes
2. Normalize to common scale
3. Add to feature vector:
   - Primary timeframe: weight = 1.0
   - Secondary timeframe: weight = 0.7
   - Tertiary timeframe: weight = 0.5

**Trend Alignment**:
```cpp
bool trendAligned = (
    (tf1_trend == BUY && tf2_trend == BUY && tf3_trend == BUY) ||
    (tf1_trend == SELL && tf2_trend == SELL && tf3_trend == SELL)
);

if(trendAligned) {
    confidence *= 1.15;  // Boost confidence
}
```

### 8. Market Type Detection

**Symbol Classification**:
```cpp
bool IsCryptoSymbol(symbol) {
    // Check for crypto keywords
    return (contains(symbol, "BTC") || 
            contains(symbol, "ETH") ||
            contains(symbol, "XRP") ||
            contains(symbol, "LTC") ||
            contains(symbol, "USDT"));
}

bool IsForexSymbol(symbol) {
    // Check for forex currencies
    return (contains(symbol, "USD") ||
            contains(symbol, "EUR") ||
            contains(symbol, "GBP") ||
            contains(symbol, "JPY"));
}
```

**Market-Specific Adjustments**:
```cpp
if(IsCrypto) {
    stopLoss *= CryptoVolatilityFactor;
    takeProfit *= CryptoVolatilityFactor;
    spreadTolerance = higher;
}
else if(IsForex) {
    spreadLimit = ForexSpreadLimit;
    if(spread > spreadLimit) {
        return;  // Skip trade
    }
}
```

## Data Flow

### Trade Execution Flow

```
1. OnTick() triggered by new bar
   ↓
2. Check daily drawdown limit
   ↓
3. AnalyzeMarket()
   ├─ Collect price data
   ├─ Calculate technical indicators
   ├─ Normalize features
   └─ Generate technical signal
   ↓
4. NeuralNetworkPredict()
   ├─ Forward propagation
   └─ Calculate confidence
   ↓
5. Pattern Recognition
   ├─ Compare with historical patterns
   └─ Adjust confidence
   ↓
6. Decision Logic
   ├─ Check confidence threshold
   ├─ Verify signal alignment
   └─ Check risk limits
   ↓
7. OpenTrade() or ManagePositions()
   ├─ Calculate position size
   ├─ Set stop loss / take profit
   └─ Execute order
   ↓
8. Adaptive Learning
   ├─ Store pattern in memory
   └─ Update neural network weights
```

### Learning Feedback Loop

```
Trade Opened
   ↓
Position Managed (trailing stop, monitoring)
   ↓
Trade Closed
   ↓
Outcome Analysis
   ├─ Calculate profit/loss
   ├─ Update statistics
   └─ Store in trade history
   ↓
Adaptive Learning
   ├─ Calculate recent win rate
   ├─ Adjust neural network weights
   ├─ Reinforce/penalize patterns
   └─ Update memory
   ↓
Future Predictions Improved
```

## Performance Optimization

### Computational Complexity

**Per Tick Operations**:
- Indicator calculations: O(n) where n = period
- Neural network forward pass: O(l × n²) where l = layers, n = neurons
- Pattern matching: O(m × f) where m = memory size, f = features
- Total: O(n + l×n² + m×f)

**Optimization Strategies**:
1. **Lazy Evaluation**: Only calculate on new bars
2. **Indicator Caching**: MT5 handles indicator buffering
3. **Memory Limitation**: Cap memory size to prevent slowdown
4. **Efficient Data Structures**: Use arrays instead of dynamic structures

### Memory Management

**Memory Usage**:
```
Neural Network Weights: 100 × 100 × 8 bytes = 80 KB
Pattern Memory: 500 × (50 × 8 + 40) bytes = 216 KB
Trade History: 500 × 100 bytes = 50 KB
Total: ~350 KB (negligible)
```

**Memory Safety**:
- Fixed-size arrays to prevent allocation issues
- Circular buffer for trade history
- Regular cleanup of old data

## Testing & Validation

### Unit Testing Approach

1. **Neural Network Tests**:
   - Verify forward propagation
   - Check activation functions
   - Test weight initialization

2. **Signal Generation Tests**:
   - Test indicator calculations
   - Verify signal combination logic
   - Check edge cases (extreme values)

3. **Risk Management Tests**:
   - Verify position size calculations
   - Test stop loss/take profit placement
   - Check daily drawdown limits

### Integration Testing

1. **Strategy Tester**: Use MT5 built-in backtesting
2. **Visual Mode**: Observe decision-making process
3. **Optimization**: Test parameter robustness
4. **Forward Testing**: Demo account validation

### Performance Metrics

**Key Metrics Tracked**:
```cpp
int g_totalTrades;           // Total number of trades
int g_winningTrades;         // Number of winning trades
double g_totalProfit;        // Cumulative profit
double g_dailyProfit;        // Daily profit tracking
double g_performanceMetrics[]; // Additional metrics
```

**Calculated Metrics**:
- Win Rate = winningTrades / totalTrades
- Profit Factor = grossProfit / grossLoss
- Average Win = totalWinProfit / winningTrades
- Average Loss = totalLossProfit / losingTrades
- Expectancy = (winRate × avgWin) - (lossRate × avgLoss)

## Future Enhancements

### Potential Improvements

1. **Advanced Neural Networks**:
   - LSTM (Long Short-Term Memory) for time series
   - CNN (Convolutional Neural Network) for pattern recognition
   - Ensemble methods combining multiple networks

2. **Enhanced Learning**:
   - Reinforcement learning (Q-learning, DQN)
   - Transfer learning from other markets
   - Online learning with mini-batches

3. **Additional Features**:
   - News sentiment analysis integration
   - Order book analysis (for crypto)
   - Correlation analysis across pairs
   - Market regime detection

4. **Risk Management**:
   - Kelly Criterion for optimal position sizing
   - Portfolio-based risk allocation
   - Correlation-adjusted exposure

5. **Performance**:
   - GPU acceleration for neural network
   - Parallel processing of multiple symbols
   - Cloud-based distributed learning

## Technical Requirements

### Minimum Requirements
- MetaTrader 5 platform (build 3000+)
- Windows 7 or later / Wine on Linux
- 2GB RAM
- 1 GHz processor

### Recommended Requirements
- MetaTrader 5 latest version
- Windows 10/11 or VPS
- 4GB+ RAM
- 2+ GHz multi-core processor
- SSD storage
- Low-latency internet connection

### Broker Requirements
- MT5 support
- Allow Expert Advisor trading
- Reasonable spreads
- Reliable execution
- Historical data availability

## Conclusion

The AI Trader represents a sophisticated approach to algorithmic trading, combining classical technical analysis with modern machine learning techniques. The modular architecture allows for easy extension and customization while maintaining robust risk management and adaptive learning capabilities.

The system is designed to be both powerful for advanced users and accessible for beginners, with extensive configuration options and comprehensive documentation.

---

For implementation details, see the source code in `AI_Trader.mq5`.
For usage instructions, see `USER_GUIDE.md`.
For configuration examples, see `CONFIGURATION_EXAMPLES.md`.
