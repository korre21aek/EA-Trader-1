# AI Trader Configuration Examples

This document provides pre-configured parameter sets for different trading styles and markets.

## Quick Start Configurations

### 1. Conservative Forex Trader

**Best for**: New users, small accounts, stable income
**Risk Level**: Low
**Expected Win Rate**: 55-60%

```
=== AI & Machine Learning Settings ===
NeuralLayers = 3
NeuronsPerLayer = 10
LearningRate = 0.01
TrainingPeriod = 100
ConfidenceThreshold = 0.75

=== Market Analysis Settings ===
UseMultiTimeframe = true
TimeFrame1 = H1
TimeFrame2 = H4
TimeFrame3 = D1
AnalysisPeriod = 50

=== Technical Indicators ===
UseRSI = true
RSI_Period = 14
UseMACD = true
MACD_Fast = 12
MACD_Slow = 26
MACD_Signal = 9
UseBollinger = true
BB_Period = 20
BB_Deviation = 2.0
UseATR = true
ATR_Period = 14

=== Risk Management ===
RiskPercent = 0.5
MaxDailyDrawdown = 3.0
TakeProfitMultiplier = 2.5
StopLossATRMultiplier = 2.5
MaxOpenTrades = 2
UseTrailingStop = true
TrailingStopATRMultiplier = 1.5

=== Market Type Settings ===
TradeCrypto = false
TradeForex = true
CryptoVolatilityFactor = 1.5
ForexSpreadLimit = 2.0

=== Advanced AI Features ===
UsePatternRecognition = true
UseSentimentAnalysis = true
UseAdaptiveLearning = true
MemorySize = 500
UseDynamicPositioning = true
```

**Recommended Pairs**: EUR/USD, GBP/USD, USD/JPY, AUD/USD

---

### 2. Aggressive Crypto Trader

**Best for**: Experienced traders, crypto volatility
**Risk Level**: High
**Expected Win Rate**: 50-55%

```
=== AI & Machine Learning Settings ===
NeuralLayers = 4
NeuronsPerLayer = 15
LearningRate = 0.015
TrainingPeriod = 150
ConfidenceThreshold = 0.60

=== Market Analysis Settings ===
UseMultiTimeframe = true
TimeFrame1 = M15
TimeFrame2 = H1
TimeFrame3 = H4
AnalysisPeriod = 50

=== Technical Indicators ===
UseRSI = true
RSI_Period = 14
UseMACD = true
MACD_Fast = 12
MACD_Slow = 26
MACD_Signal = 9
UseBollinger = true
BB_Period = 20
BB_Deviation = 2.5
UseATR = true
ATR_Period = 14

=== Risk Management ===
RiskPercent = 2.0
MaxDailyDrawdown = 7.0
TakeProfitMultiplier = 2.0
StopLossATRMultiplier = 1.8
MaxOpenTrades = 5
UseTrailingStop = true
TrailingStopATRMultiplier = 1.2

=== Market Type Settings ===
TradeCrypto = true
TradeForex = false
CryptoVolatilityFactor = 2.0
ForexSpreadLimit = 3.0

=== Advanced AI Features ===
UsePatternRecognition = true
UseSentimentAnalysis = true
UseAdaptiveLearning = true
MemorySize = 800
UseDynamicPositioning = true
```

**Recommended Pairs**: BTC/USD, ETH/USD, XRP/USD, LTC/USD

---

### 3. Balanced Multi-Market Trader

**Best for**: Diversification, moderate risk
**Risk Level**: Medium
**Expected Win Rate**: 53-58%

```
=== AI & Machine Learning Settings ===
NeuralLayers = 3
NeuronsPerLayer = 12
LearningRate = 0.012
TrainingPeriod = 120
ConfidenceThreshold = 0.65

=== Market Analysis Settings ===
UseMultiTimeframe = true
TimeFrame1 = M15
TimeFrame2 = H1
TimeFrame3 = H4
AnalysisPeriod = 50

=== Technical Indicators ===
UseRSI = true
RSI_Period = 14
UseMACD = true
MACD_Fast = 12
MACD_Slow = 26
MACD_Signal = 9
UseBollinger = true
BB_Period = 20
BB_Deviation = 2.0
UseATR = true
ATR_Period = 14

=== Risk Management ===
RiskPercent = 1.0
MaxDailyDrawdown = 5.0
TakeProfitMultiplier = 2.0
StopLossATRMultiplier = 2.0
MaxOpenTrades = 3
UseTrailingStop = true
TrailingStopATRMultiplier = 1.5

=== Market Type Settings ===
TradeCrypto = true
TradeForex = true
CryptoVolatilityFactor = 1.5
ForexSpreadLimit = 3.0

=== Advanced AI Features ===
UsePatternRecognition = true
UseSentimentAnalysis = true
UseAdaptiveLearning = true
MemorySize = 500
UseDynamicPositioning = true
```

**Recommended Pairs**: EUR/USD, GBP/USD, BTC/USD, ETH/USD

---

### 4. Scalping Strategy

**Best for**: High-frequency trading, quick profits
**Risk Level**: Medium-High
**Expected Win Rate**: 52-57%

```
=== AI & Machine Learning Settings ===
NeuralLayers = 2
NeuronsPerLayer = 8
LearningRate = 0.02
TrainingPeriod = 80
ConfidenceThreshold = 0.60

=== Market Analysis Settings ===
UseMultiTimeframe = true
TimeFrame1 = M1
TimeFrame2 = M5
TimeFrame3 = M15
AnalysisPeriod = 30

=== Technical Indicators ===
UseRSI = true
RSI_Period = 10
UseMACD = true
MACD_Fast = 8
MACD_Slow = 17
MACD_Signal = 9
UseBollinger = true
BB_Period = 15
BB_Deviation = 2.0
UseATR = true
ATR_Period = 10

=== Risk Management ===
RiskPercent = 0.5
MaxDailyDrawdown = 4.0
TakeProfitMultiplier = 1.5
StopLossATRMultiplier = 1.5
MaxOpenTrades = 4
UseTrailingStop = true
TrailingStopATRMultiplier = 1.0

=== Market Type Settings ===
TradeCrypto = false
TradeForex = true
CryptoVolatilityFactor = 1.5
ForexSpreadLimit = 1.5

=== Advanced AI Features ===
UsePatternRecognition = true
UseSentimentAnalysis = false
UseAdaptiveLearning = true
MemorySize = 400
UseDynamicPositioning = true
```

**Recommended Pairs**: EUR/USD, GBP/USD (major pairs with low spread)
**Note**: Requires VPS for consistent execution

---

### 5. Swing Trading Strategy

**Best for**: Long-term positions, less active monitoring
**Risk Level**: Low-Medium
**Expected Win Rate**: 55-62%

```
=== AI & Machine Learning Settings ===
NeuralLayers = 4
NeuronsPerLayer = 12
LearningRate = 0.008
TrainingPeriod = 150
ConfidenceThreshold = 0.70

=== Market Analysis Settings ===
UseMultiTimeframe = true
TimeFrame1 = H4
TimeFrame2 = D1
TimeFrame3 = W1
AnalysisPeriod = 60

=== Technical Indicators ===
UseRSI = true
RSI_Period = 14
UseMACD = true
MACD_Fast = 12
MACD_Slow = 26
MACD_Signal = 9
UseBollinger = true
BB_Period = 20
BB_Deviation = 2.0
UseATR = true
ATR_Period = 14

=== Risk Management ===
RiskPercent = 1.5
MaxDailyDrawdown = 5.0
TakeProfitMultiplier = 3.0
StopLossATRMultiplier = 2.5
MaxOpenTrades = 2
UseTrailingStop = true
TrailingStopATRMultiplier = 2.0

=== Market Type Settings ===
TradeCrypto = false
TradeForex = true
CryptoVolatilityFactor = 1.5
ForexSpreadLimit = 3.0

=== Advanced AI Features ===
UsePatternRecognition = true
UseSentimentAnalysis = true
UseAdaptiveLearning = true
MemorySize = 600
UseDynamicPositioning = true
```

**Recommended Pairs**: All major pairs, some commodities (XAU/USD)

---

### 6. High-Performance Neural Network

**Best for**: Maximum AI capability, powerful VPS
**Risk Level**: Medium
**Expected Win Rate**: 56-65%

```
=== AI & Machine Learning Settings ===
NeuralLayers = 5
NeuronsPerLayer = 20
LearningRate = 0.01
TrainingPeriod = 200
ConfidenceThreshold = 0.68

=== Market Analysis Settings ===
UseMultiTimeframe = true
TimeFrame1 = M15
TimeFrame2 = H1
TimeFrame3 = H4
AnalysisPeriod = 80

=== Technical Indicators ===
UseRSI = true
RSI_Period = 14
UseMACD = true
MACD_Fast = 12
MACD_Slow = 26
MACD_Signal = 9
UseBollinger = true
BB_Period = 20
BB_Deviation = 2.0
UseATR = true
ATR_Period = 14

=== Risk Management ===
RiskPercent = 1.2
MaxDailyDrawdown = 5.0
TakeProfitMultiplier = 2.5
StopLossATRMultiplier = 2.2
MaxOpenTrades = 3
UseTrailingStop = true
TrailingStopATRMultiplier = 1.5

=== Market Type Settings ===
TradeCrypto = true
TradeForex = true
CryptoVolatilityFactor = 1.8
ForexSpreadLimit = 3.0

=== Advanced AI Features ===
UsePatternRecognition = true
UseSentimentAnalysis = true
UseAdaptiveLearning = true
MemorySize = 1000
UseDynamicPositioning = true
```

**Recommended**: For users with powerful VPS and multiple currency pairs
**Note**: Requires more computational resources

---

## Market-Specific Configurations

### Bitcoin (BTC/USD)

```
TradeCrypto = true
TradeForex = false
CryptoVolatilityFactor = 2.0
ConfidenceThreshold = 0.65
RiskPercent = 1.5
StopLossATRMultiplier = 2.0
TakeProfitMultiplier = 2.0
TimeFrame1 = M15
TimeFrame2 = H1
TimeFrame3 = H4
```

### Ethereum (ETH/USD)

```
TradeCrypto = true
TradeForex = false
CryptoVolatilityFactor = 2.2
ConfidenceThreshold = 0.63
RiskPercent = 1.3
StopLossATRMultiplier = 1.9
TakeProfitMultiplier = 2.2
TimeFrame1 = M15
TimeFrame2 = H1
TimeFrame3 = H4
```

### EUR/USD

```
TradeCrypto = false
TradeForex = true
ForexSpreadLimit = 2.0
ConfidenceThreshold = 0.68
RiskPercent = 1.0
StopLossATRMultiplier = 2.0
TakeProfitMultiplier = 2.5
TimeFrame1 = M15
TimeFrame2 = H1
TimeFrame3 = H4
```

### GBP/USD

```
TradeCrypto = false
TradeForex = true
ForexSpreadLimit = 2.5
ConfidenceThreshold = 0.67
RiskPercent = 1.0
StopLossATRMultiplier = 2.2
TakeProfitMultiplier = 2.3
TimeFrame1 = M15
TimeFrame2 = H1
TimeFrame3 = H4
```

### XAU/USD (Gold)

```
TradeCrypto = false
TradeForex = true
ForexSpreadLimit = 4.0
ConfidenceThreshold = 0.70
RiskPercent = 0.8
StopLossATRMultiplier = 2.5
TakeProfitMultiplier = 3.0
TimeFrame1 = H1
TimeFrame2 = H4
TimeFrame3 = D1
```

---

## Account Size Recommendations

### Small Account ($500 - $2,000)

```
RiskPercent = 0.5
MaxOpenTrades = 1
MaxDailyDrawdown = 2.0
ConfidenceThreshold = 0.75
```

### Medium Account ($2,000 - $10,000)

```
RiskPercent = 1.0
MaxOpenTrades = 3
MaxDailyDrawdown = 4.0
ConfidenceThreshold = 0.68
```

### Large Account ($10,000 - $50,000)

```
RiskPercent = 1.0
MaxOpenTrades = 5
MaxDailyDrawdown = 5.0
ConfidenceThreshold = 0.65
```

### Professional Account ($50,000+)

```
RiskPercent = 0.8
MaxOpenTrades = 10
MaxDailyDrawdown = 5.0
ConfidenceThreshold = 0.65
UseDynamicPositioning = true
```

---

## Time-Based Configurations

### Asian Session (Best: JPY, AUD, NZD pairs)

```
TimeFrame1 = M15
TimeFrame2 = H1
TimeFrame3 = H4
RSI_Period = 14
MACD_Fast = 12
MACD_Slow = 26
ConfidenceThreshold = 0.65
```

### European Session (Best: EUR, GBP pairs)

```
TimeFrame1 = M15
TimeFrame2 = H1
TimeFrame3 = H4
RSI_Period = 14
MACD_Fast = 12
MACD_Slow = 26
ConfidenceThreshold = 0.68
```

### US Session (Best: USD pairs)

```
TimeFrame1 = M15
TimeFrame2 = H1
TimeFrame3 = H4
RSI_Period = 14
MACD_Fast = 12
MACD_Slow = 26
ConfidenceThreshold = 0.67
```

### 24/7 Crypto Trading

```
TimeFrame1 = M15
TimeFrame2 = H1
TimeFrame3 = H4
RSI_Period = 14
MACD_Fast = 12
MACD_Slow = 26
ConfidenceThreshold = 0.63
TradeCrypto = true
TradeForex = false
```

---

## Optimization Tips

### Parameters to Optimize First

1. **ConfidenceThreshold** (0.55 - 0.80, step 0.05)
2. **RiskPercent** (0.5 - 2.0, step 0.25)
3. **TakeProfitMultiplier** (1.5 - 3.5, step 0.25)
4. **StopLossATRMultiplier** (1.5 - 3.0, step 0.25)

### Secondary Optimization

1. **RSI_Period** (10 - 20, step 2)
2. **MACD_Fast** (8 - 16, step 2)
3. **MACD_Slow** (20 - 32, step 2)
4. **NeuronsPerLayer** (8 - 20, step 2)

### Advanced Optimization

1. **NeuralLayers** (2 - 5, step 1)
2. **LearningRate** (0.005 - 0.02, step 0.005)
3. **TrainingPeriod** (50 - 200, step 25)
4. **MemorySize** (300 - 1000, step 100)

---

## Testing Recommendations

1. **Always backtest first**: At least 6 months of data
2. **Forward test on demo**: Minimum 2 weeks
3. **Start with conservative settings**
4. **Monitor closely for first 50 trades**
5. **Optimize quarterly based on performance**

---

## Performance Expectations

| Strategy Type | Expected Win Rate | Avg R:R | Trades/Week | Drawdown |
|--------------|------------------|---------|-------------|----------|
| Conservative Forex | 55-60% | 2.5:1 | 5-10 | 10-15% |
| Aggressive Crypto | 50-55% | 2:1 | 15-30 | 20-30% |
| Balanced Multi-Market | 53-58% | 2:1 | 10-20 | 15-20% |
| Scalping | 52-57% | 1.5:1 | 50-100 | 10-18% |
| Swing Trading | 55-62% | 3:1 | 2-5 | 12-18% |
| High-Performance | 56-65% | 2.5:1 | 15-25 | 15-22% |

**Note**: These are estimates based on typical backtesting results. Live performance may vary.

---

## Important Reminders

⚠️ **Before using any configuration**:

1. Backtest thoroughly on your specific broker and symbols
2. Test on demo account first
3. Understand each parameter's impact
4. Start with lower risk than shown
5. Monitor performance regularly
6. Adjust based on market conditions
7. Never risk more than you can afford to lose

---

## Questions?

For more information, see:
- `USER_GUIDE.md` - Complete usage guide
- `README.md` - Project overview
- GitHub Issues - For support and questions
