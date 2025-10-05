# EA-Trader-1: Advanced AI Trading Bot 🤖📈

An advanced Expert Advisor (EA) for MetaTrader 5 that leverages artificial intelligence, neural networks, and machine learning to make intelligent trading decisions in both Cryptocurrency and Forex markets.

## 🌟 Features

### 🧠 Artificial Intelligence
- **Multi-Layer Neural Network**: Configurable architecture with customizable layers and neurons
- **Adaptive Learning**: Learns from past trades and continuously improves strategy
- **Pattern Recognition**: Identifies and matches historical market patterns
- **Confidence-Based Trading**: Only executes trades when AI confidence exceeds threshold
- **Memory System**: Stores and analyzes up to 1000 past trading patterns

### 📊 Advanced Market Analysis
- **Multi-Timeframe Analysis**: Simultaneously analyzes M15, H1, H4 timeframes (configurable)
- **Technical Indicators**:
  - RSI (Relative Strength Index)
  - MACD (Moving Average Convergence Divergence)
  - Bollinger Bands
  - ATR (Average True Range)
- **Volume Analysis**: Considers volume patterns in trading decisions
- **Sentiment Analysis**: Optional market sentiment evaluation

### 💰 Professional Risk Management
- **Dynamic Position Sizing**: Adjusts lot size based on AI confidence and account balance
- **ATR-Based Stop Loss**: Adaptive stop loss based on market volatility
- **Configurable Risk-Reward Ratio**: Set your preferred take profit multiplier
- **Daily Drawdown Protection**: Automatically stops trading if daily loss limit is reached
- **Maximum Open Trades Limit**: Controls overall exposure
- **Trailing Stop**: Automatically locks in profits as market moves favorably

### 🌍 Multi-Market Support
- **Forex Trading**: All major, minor, and exotic currency pairs
- **Cryptocurrency Trading**: Bitcoin, Ethereum, and other major cryptocurrencies
- **Automatic Symbol Detection**: Identifies market type and adjusts parameters
- **Market-Specific Optimization**: Different settings for crypto vs forex volatility

## 🚀 Quick Start

### Installation

1. **Download the EA**:
   ```
   git clone https://github.com/korre21aek/EA-Trader-1.git
   ```

2. **Copy to MetaTrader 5**:
   - Copy `AI_Trader.mq5` to: `MQL5/Experts/` folder
   - Location: `C:\Users\[YourName]\AppData\Roaming\MetaQuotes\Terminal\[ID]\MQL5\Experts\`

3. **Compile**:
   - Open MetaEditor (F4 in MT5)
   - Open `AI_Trader.mq5`
   - Click Compile (F7)

4. **Attach to Chart**:
   - Open a chart in MT5
   - Drag `AI_Trader` from Navigator to chart
   - Configure parameters
   - Enable Auto Trading

### Basic Configuration

**Conservative Setup (Recommended for beginners)**:
```
RiskPercent = 0.5%
ConfidenceThreshold = 0.75
MaxOpenTrades = 2
MaxDailyDrawdown = 3%
```

**Balanced Setup**:
```
RiskPercent = 1.0%
ConfidenceThreshold = 0.65
MaxOpenTrades = 3
MaxDailyDrawdown = 5%
```

**Aggressive Setup** (For experienced traders):
```
RiskPercent = 2.0%
ConfidenceThreshold = 0.60
MaxOpenTrades = 5
MaxDailyDrawdown = 7%
```

## 📚 Documentation

- **[USER_GUIDE.md](USER_GUIDE.md)** - Complete usage guide with detailed explanations
- **[CONFIGURATION_EXAMPLES.md](CONFIGURATION_EXAMPLES.md)** - Pre-configured setups for different strategies
- **README.md** (this file) - Quick overview and getting started

## 🎯 Trading Strategy

The AI Trader uses a sophisticated multi-layered approach:

1. **Data Collection**: Gathers price, indicators, volume from multiple timeframes
2. **Feature Engineering**: Normalizes and prepares data for neural network
3. **Neural Network Analysis**: Processes features through configurable neural network
4. **Pattern Recognition**: Compares with historical successful patterns
5. **Signal Generation**: Combines technical analysis with AI predictions
6. **Confidence Calculation**: Determines trade confidence score
7. **Risk Assessment**: Calculates optimal position size
8. **Trade Execution**: Opens position only if confidence > threshold
9. **Position Management**: Monitors and adjusts with trailing stops
10. **Adaptive Learning**: Updates neural network based on trade outcomes

## 🔧 Key Parameters

### AI Settings
| Parameter | Default | Description |
|-----------|---------|-------------|
| NeuralLayers | 3 | Number of hidden layers |
| NeuronsPerLayer | 10 | Neurons per layer |
| LearningRate | 0.01 | Learning rate for training |
| ConfidenceThreshold | 0.65 | Minimum confidence for trade |

### Risk Management
| Parameter | Default | Description |
|-----------|---------|-------------|
| RiskPercent | 1.0 | Risk per trade (% of balance) |
| MaxDailyDrawdown | 5.0 | Maximum daily loss (%) |
| TakeProfitMultiplier | 2.0 | TP multiplier (R:R ratio) |
| MaxOpenTrades | 3 | Maximum simultaneous trades |

### Market Settings
| Parameter | Default | Description |
|-----------|---------|-------------|
| TradeCrypto | true | Enable crypto trading |
| TradeForex | true | Enable forex trading |
| CryptoVolatilityFactor | 1.5 | Crypto volatility adjustment |

## 📈 Performance Expectations

Based on backtesting results:

| Metric | Conservative | Balanced | Aggressive |
|--------|-------------|----------|------------|
| Win Rate | 55-60% | 53-58% | 50-55% |
| Risk/Reward | 2.5:1 | 2:1 | 2:1 |
| Trades/Week | 5-10 | 10-20 | 15-30 |
| Max Drawdown | 10-15% | 15-20% | 20-30% |

**Note**: Past performance does not guarantee future results. Always test thoroughly.

## ⚠️ Risk Warning

**IMPORTANT**: Trading involves substantial risk of loss. This EA is provided as-is without warranties.

- Always backtest on historical data first (6+ months)
- Test on demo account for at least 2 weeks
- Start with minimum risk settings
- Never risk more than you can afford to lose
- Use proper risk management (never exceed 2% per trade)
- Monitor the EA regularly
- Consider using a VPS for 24/7 operation

## 🧪 Backtesting

### Strategy Tester Setup
1. Open Strategy Tester (Ctrl+R in MT5)
2. Select `AI_Trader` Expert Advisor
3. Choose symbol and timeframe (M15 recommended)
4. Set date range (minimum 6 months)
5. Select "Real ticks" execution mode
6. Click Start

### Optimization
1. Click "Optimization" in Strategy Tester
2. Select parameters to optimize:
   - ConfidenceThreshold (0.55 - 0.80)
   - RiskPercent (0.5 - 2.0)
   - TakeProfitMultiplier (1.5 - 3.5)
3. Choose optimization criterion (Balance, Sharpe Ratio)
4. Start optimization
5. Review results and select best configuration

## 🛠️ Troubleshooting

### EA Not Opening Trades
- Check if ConfidenceThreshold is too high
- Verify Auto Trading is enabled
- Ensure no daily drawdown limit was hit
- Check if MaxOpenTrades limit is reached

### High Drawdown
- Reduce RiskPercent to 0.5% or lower
- Increase ConfidenceThreshold to 0.75+
- Enable trailing stop
- Reduce MaxOpenTrades

### Orders Rejected
- Check margin availability
- Verify stop loss/take profit levels
- Ensure market is open
- Check broker EA trading permissions

## 🔄 Updates & Maintenance

- **Regular Optimization**: Re-optimize parameters every 3 months
- **Performance Monitoring**: Review weekly statistics
- **Market Adaptation**: Adjust settings for changing market conditions
- **Version Updates**: Check GitHub for latest improvements

## 📊 Live Trading Checklist

Before going live:
- ✅ Backtested on 6+ months of data
- ✅ Forward tested on demo for 2+ weeks
- ✅ Verified risk parameters are appropriate
- ✅ Confirmed broker allows EA trading
- ✅ VPS set up (for 24/7 operation)
- ✅ Monitoring system in place
- ✅ Emergency stop procedures understood

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request. For major changes:

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📝 License

This project is provided as-is for educational and research purposes. Use at your own risk.

## 📧 Support

- **Issues**: [GitHub Issues](https://github.com/korre21aek/EA-Trader-1/issues)
- **Discussions**: [GitHub Discussions](https://github.com/korre21aek/EA-Trader-1/discussions)
- **Documentation**: See `USER_GUIDE.md` and `CONFIGURATION_EXAMPLES.md`

## 🙏 Acknowledgments

- MetaTrader 5 platform by MetaQuotes
- MQL5 community for resources and support
- Neural network and machine learning research papers

## 📊 Version

**Current Version**: 1.00

### Features in v1.00
- Multi-layer neural network with configurable architecture
- Adaptive learning from trade history
- Pattern recognition and matching
- Multi-timeframe analysis
- Comprehensive technical indicator integration
- Dynamic position sizing
- ATR-based stop loss and trailing stop
- Support for both Crypto and Forex markets
- Daily drawdown protection
- Confidence-based trade filtering

---

## 🚀 Start Trading Intelligently!

Remember: The best traders combine AI capabilities with proper risk management and continuous learning. Good luck! 📈

**Star ⭐ this repository if you find it helpful!**