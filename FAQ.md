# Frequently Asked Questions (FAQ)

## General Questions

### What is AI Trader?
AI Trader is an Expert Advisor (EA) for MetaTrader 5 that uses artificial intelligence, specifically neural networks, to analyze markets and make trading decisions. It supports both Forex and Cryptocurrency trading with adaptive learning capabilities.

### Is AI Trader really using AI?
Yes! AI Trader implements:
- Multi-layer neural network with configurable architecture
- Pattern recognition and matching algorithms
- Adaptive learning that improves from trade history
- Confidence-based decision making
- Feature engineering and normalization

### Is this a "holy grail" trading system?
No. There is no holy grail in trading. AI Trader is a sophisticated tool that can help identify trading opportunities, but it:
- Cannot guarantee profits
- Requires proper configuration and risk management
- Needs regular monitoring and optimization
- Works best when combined with trader's knowledge
- Performance varies with market conditions

### How much money can I make with AI Trader?
We cannot and do not make profit guarantees. Your results will depend on:
- Your risk management settings
- Market conditions
- Broker spreads and commissions
- Capital size
- Trading pair selected
- Parameter optimization

**Always start with demo testing and conservative settings.**

## Installation & Setup

### What do I need to run AI Trader?
- MetaTrader 5 platform (build 3000 or later)
- Windows computer or VPS (Wine on Linux works too)
- MT5 account (demo or live)
- Minimum 2GB RAM
- Basic understanding of trading

### Can I use it on MetaTrader 4?
No. AI Trader is built specifically for MetaTrader 5 using MQL5 language. It cannot run on MT4.

### Do I need a VPS?
Not required, but recommended if you want:
- 24/7 trading without your computer running
- Better execution speed
- No interruptions from power/internet outages
- Trading during sleep/travel

### How do I install it?
See [QUICK_SETUP.md](QUICK_SETUP.md) for detailed instructions. Quick version:
1. Copy `AI_Trader.mq5` to MT5's `MQL5/Experts/` folder
2. Compile in MetaEditor (F7)
3. Drag onto chart
4. Enable Auto Trading

### The EA won't compile. What should I do?
- Ensure you have the complete `AI_Trader.mq5` file (not truncated)
- Update MetaTrader 5 to latest version
- Check for error messages in compilation log
- Try closing and reopening MetaEditor

## Configuration & Parameters

### What settings should I start with?
Use these conservative settings for first-time use:
```
RiskPercent = 0.5
ConfidenceThreshold = 0.75
MaxOpenTrades = 2
MaxDailyDrawdown = 3.0
```

See [CONFIGURATION_EXAMPLES.md](CONFIGURATION_EXAMPLES.md) for more presets.

### What is ConfidenceThreshold?
It's the minimum confidence level (0-1) the AI must have before opening a trade. Higher values (0.75-0.80) mean fewer but more confident trades. Lower values (0.55-0.65) mean more frequent but less certain trades.

### What is RiskPercent?
The percentage of your account balance to risk on each trade. For example:
- 0.5% = Very conservative (recommended for beginners)
- 1.0% = Moderate risk (standard)
- 2.0% = Aggressive (experienced traders only)

Never exceed 2% per trade.

### How many neurons and layers should I use?
Defaults work well for most cases:
- 3 layers, 10 neurons each (balanced)
- For more accuracy: 4-5 layers, 15-20 neurons (slower)
- For faster execution: 2 layers, 8 neurons (less accurate)

More is not always better - can lead to overfitting.

### Should I enable all AI features?
Yes, for best performance enable:
- UsePatternRecognition = true
- UseAdaptiveLearning = true
- UseDynamicPositioning = true
- UseMultiTimeframe = true

Disable SentimentAnalysis if you notice it affecting performance (it's mostly structural currently).

### What's the difference between Crypto and Forex settings?
Crypto markets are more volatile, so:
- Higher volatility factor (1.5-2.0)
- Wider stop losses
- Different spread tolerances
- 24/7 trading vs Forex sessions

The EA automatically detects and adjusts.

## Trading & Performance

### How often does the EA trade?
Varies based on:
- ConfidenceThreshold setting
- Market conditions
- Timeframe used
- Symbol volatility

Typical ranges:
- Conservative: 5-10 trades per week
- Moderate: 10-20 trades per week
- Aggressive: 15-30+ trades per week

### Why isn't the EA opening trades?
Common reasons:
1. **Confidence too low**: AI doesn't see good opportunities
2. **Threshold too high**: Lower ConfidenceThreshold
3. **Max trades reached**: Close positions or increase MaxOpenTrades
4. **Daily drawdown hit**: Wait for next day or adjust limit
5. **Poor market conditions**: No clear signals
6. **Auto trading disabled**: Enable with Ctrl+E

### The EA is losing money. What should I do?
1. **Stop trading immediately** (disable Auto Trading)
2. **Review settings**: Are they too aggressive?
3. **Check market conditions**: Is market trending or ranging?
4. **Backtest again**: With current settings on recent data
5. **Optimize parameters**: Use Strategy Tester optimization
6. **Start fresh**: Return to conservative settings
7. **Consider market**: Maybe this pair isn't suitable right now

### What's a good win rate?
- **50-55%**: Acceptable with good R:R ratio (2:1 or better)
- **55-60%**: Good performance
- **60%+**: Excellent (but verify it's not curve-fitting)
- **<50%**: Need adjustment or different market

Win rate alone doesn't determine profitability - risk/reward matters more.

### Should I use trailing stop?
**Yes**, it helps:
- Lock in profits as market moves in your favor
- Reduce losses from reversals
- Maximize profitable trades

Only disable if you have a specific strategy requiring fixed exits.

## Backtesting & Optimization

### How do I backtest the EA?
1. Press Ctrl+R to open Strategy Tester
2. Select AI_Trader
3. Choose symbol and timeframe
4. Set date range (6+ months minimum)
5. Select "Real ticks" mode for accuracy
6. Click Start

See [USER_GUIDE.md](USER_GUIDE.md) for detailed instructions.

### How much historical data do I need?
- **Minimum**: 3 months
- **Recommended**: 6-12 months
- **Optimal**: 1-2 years

More data gives more reliable results but takes longer to test.

### What are good backtesting results?
Look for:
- **Win Rate**: 50%+ (ideally 55-60%)
- **Profit Factor**: >1.5 (ideally >2.0)
- **Max Drawdown**: <20% (ideally <15%)
- **Sharpe Ratio**: >1.0 (ideally >1.5)
- **Total Trades**: 100+ for statistical significance

### Should I optimize parameters?
Yes, but carefully:
1. **Backtest first** with defaults
2. **Optimize key parameters**: ConfidenceThreshold, RiskPercent, TP multiplier
3. **Don't over-optimize**: Can lead to curve-fitting
4. **Forward test**: Test optimized settings on out-of-sample data
5. **Re-optimize quarterly**: Markets change

### What's the difference between backtesting and optimization?
- **Backtesting**: Tests EA with specific settings on historical data
- **Optimization**: Tests multiple parameter combinations to find best settings

Use backtesting to verify, optimization to improve.

## Risk & Safety

### Is my money safe?
Trading carries inherent risks. AI Trader includes risk management features:
- Stop losses on every trade
- Daily drawdown limits
- Maximum open trades limit
- Dynamic position sizing

But you can still lose money. Only trade what you can afford to lose.

### What's the maximum I should risk per trade?
**Never exceed 2% per trade.** Recommended:
- Beginners: 0.5%
- Intermediate: 1.0%
- Advanced: 1.5-2.0%

Lower risk = slower growth but safer account.

### Can I lose all my money?
With proper risk management settings (1% per trade, 5% daily limit), it's very unlikely to lose everything quickly. However:
- Black swan events can happen
- Always use stop losses (never disable)
- Never trade money you can't afford to lose
- Consider starting with small account

### Should I use this on a live account immediately?
**NO!** Always:
1. Backtest thoroughly (6+ months data)
2. Forward test on demo (2+ weeks)
3. Start with minimum risk on live
4. Scale up gradually as confidence builds

### What if there's a major market crash?
The EA has protections:
- Stop losses will close positions (with slippage possible)
- Daily drawdown limit stops new trades
- But extreme volatility can cause larger losses
- Consider manual intervention in extreme conditions

## Technical Questions

### How does the neural network work?
- **Input Layer**: Takes market features (20 inputs)
- **Hidden Layers**: Process features through neurons (configurable)
- **Output Layer**: Produces buy/sell signal (-1 to +1)
- **Activation**: ReLU for hidden, Tanh for output
- **Learning**: Adjusts weights based on trade outcomes

See [ARCHITECTURE.md](ARCHITECTURE.md) for detailed explanation.

### What is adaptive learning?
The EA learns from its trading history:
- Successful patterns → reinforce (increase weights)
- Failed patterns → penalize (decrease weights)
- Recent performance → adjust learning rate
- Pattern matching → compare with history

### How does pattern recognition work?
1. EA stores features of each trade (50 features)
2. Before opening new trade, compares current pattern with history
3. Finds most similar historical pattern
4. Adjusts confidence based on that pattern's outcome
5. If similar pattern was profitable → boost confidence
6. If similar pattern lost → reduce confidence

### Can I modify the source code?
Yes! It's open source. You can:
- Add new indicators
- Modify neural network architecture
- Implement new learning algorithms
- Add features you need

Please contribute improvements back to the project!

### Does it use machine learning?
Yes, it implements:
- **Supervised learning**: Learns from labeled outcomes (profitable/unprofitable)
- **Online learning**: Updates in real-time as trades complete
- **Pattern recognition**: Finds similar historical patterns
- **Adaptive algorithms**: Adjusts to changing markets

## Broker & Platform

### Does it work with any broker?
Should work with any MT5 broker that:
- Allows Expert Advisor trading
- Provides historical data
- Has reasonable spreads
- Offers reliable execution

Some brokers may have EA restrictions - check with your broker.

### Are there any broker requirements?
Recommended:
- Regulated broker (for safety)
- Low spreads (better profitability)
- Fast execution (important for EA trading)
- No restrictions on EA usage
- Good historical data quality

### Why do I get different results with different brokers?
Results vary due to:
- Different spreads
- Different commission structures
- Price feed variations
- Execution speed
- Historical data quality
- Server timezone differences

Always backtest with your specific broker's data.

### Can I run multiple instances?
Yes! You can:
- Run on multiple charts simultaneously
- Use different settings per symbol
- Trade multiple pairs at once
- Run on different timeframes

Just ensure you have enough margin and watch overall exposure.

## Troubleshooting

### EA shows "Initialization failed"
Possible causes:
- Missing indicator data
- Invalid parameter values
- Insufficient historical data
- Symbol not available

Check Experts tab for specific error message.

### Orders keep getting rejected
Check:
- Sufficient margin available
- Stop loss/take profit levels valid
- Market is open (trading hours)
- Broker allows EA trading
- Lot size within broker's limits
- Connection to server is stable

### Results differ from backtest
Normal variations include:
- Slippage (market orders vs backtest)
- Spread changes (wider in live)
- Commission differences
- Requotes and rejections
- Connection delays

10-20% variation from backtest is normal.

### How do I reset the EA?
To start fresh:
1. Remove EA from chart
2. Restart MetaTrader 5
3. Re-attach EA to chart
4. EA will reinitialize all values

Neural network weights will reset to random values.

### Where can I find logs?
MT5 Experts tab (bottom of platform) shows:
- EA initialization messages
- Trade execution logs
- AI confidence scores
- Error messages
- Daily statistics

## Advanced Topics

### Can I connect it to external ML libraries?
Not directly - MQL5 has limitations. However, you could:
- Use DLL imports (advanced)
- Implement algorithms in MQL5 (like current neural network)
- Use MT5's Python integration (experimental)
- Run external AI models and import signals

### How can I improve performance?
1. **Optimize parameters** for your specific symbol
2. **Choose right timeframe** for your strategy
3. **Select appropriate symbols** (lower spread, good volatility)
4. **Fine-tune confidence threshold** based on win rate
5. **Adjust for market conditions** (trending vs ranging)
6. **Regular re-optimization** (quarterly)
7. **Use VPS** for consistent execution

### Can I add custom indicators?
Yes! Modify the code to:
1. Initialize your indicator handle
2. Copy indicator values to buffer
3. Add to feature vector
4. Adjust neural network input size
5. Recompile EA

### What about using it for other markets?
Currently optimized for Forex and Crypto, but you could adapt for:
- Stock indices
- Commodities (Gold, Oil)
- Individual stocks (if broker offers)

May need parameter adjustments for different market characteristics.

### How do I know if I'm curve-fitting?
Warning signs:
- Amazing backtest results (>80% win rate)
- Poor forward test performance
- Results highly sensitive to parameter changes
- Only works on specific time period
- Breaks on out-of-sample data

Prevention:
- Use longer test periods
- Test on multiple symbols
- Keep parameters simple
- Verify on forward testing
- Regular re-optimization

## Getting Help

### Where can I get support?
- **Documentation**: Read [USER_GUIDE.md](USER_GUIDE.md)
- **GitHub Issues**: Report bugs and ask questions
- **GitHub Discussions**: General questions and strategy discussion
- **Configuration Examples**: See [CONFIGURATION_EXAMPLES.md](CONFIGURATION_EXAMPLES.md)

### How do I report a bug?
1. Go to [GitHub Issues](https://github.com/korre21aek/EA-Trader-1/issues)
2. Search if issue already exists
3. Create new issue with:
   - Clear description
   - Steps to reproduce
   - Expected vs actual behavior
   - MT5 version and broker
   - Screenshots/logs if applicable

### Can I request features?
Yes! Create an issue with:
- Clear description of feature
- Use case / why it's needed
- How it should work
- Example if possible

Or even better - implement it yourself and submit a Pull Request!

### How can I contribute?
We welcome contributions:
- Code improvements
- Bug fixes
- Documentation updates
- New features
- Testing and feedback

See README.md for contribution guidelines.

## Legal & Disclaimers

### Is this legal to use?
Yes, using automated trading software (EAs) is legal in most jurisdictions. However:
- Check your broker's terms of service
- Verify local regulations
- Some countries have specific rules about automated trading

### What's the license?
MIT License - see [LICENSE](LICENSE) file. You can:
- Use commercially
- Modify and distribute
- Private use
- Patent use

But:
- No warranty provided
- No liability from authors
- Must include license and copyright

### Is there a warranty?
No. Software is provided "as-is" without any warranty. Trading is risky and you can lose money. See [LICENSE](LICENSE) for full disclaimer.

---

## Still Have Questions?

If your question isn't answered here:

1. Check the [USER_GUIDE.md](USER_GUIDE.md) for detailed information
2. Read [CONFIGURATION_EXAMPLES.md](CONFIGURATION_EXAMPLES.md) for setup guidance
3. Review [ARCHITECTURE.md](ARCHITECTURE.md) for technical details
4. Search [GitHub Issues](https://github.com/korre21aek/EA-Trader-1/issues)
5. Ask in [GitHub Discussions](https://github.com/korre21aek/EA-Trader-1/discussions)

---

**Remember**: No EA can guarantee profits. Always use proper risk management and never trade money you can't afford to lose. Good luck! 📈
