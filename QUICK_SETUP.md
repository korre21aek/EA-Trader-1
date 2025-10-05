# Quick Setup Guide - AI Trader

Get started with AI Trader in 5 minutes! ⚡

## Step 1: Install MetaTrader 5

If you don't have MT5 yet:

1. Download from [MetaQuotes official website](https://www.metatrader5.com/en/download)
2. Install MT5 on your computer
3. Open a demo or live account with your broker

## Step 2: Copy the EA File

1. **Download** `AI_Trader.mq5` from this repository
2. **Open** the MT5 data folder:
   - In MT5, click: `File` → `Open Data Folder`
   - Or press `Ctrl+Shift+D`
3. **Navigate** to: `MQL5/Experts/` folder
4. **Copy** `AI_Trader.mq5` into the Experts folder

## Step 3: Compile the EA

1. **Open MetaEditor**:
   - In MT5, press `F4`
   - Or click the MetaEditor icon
2. **Open the EA**:
   - In MetaEditor Navigator, expand `Experts`
   - Double-click `AI_Trader.mq5`
3. **Compile**:
   - Press `F7` or click the "Compile" button
   - Check for "0 error(s), 0 warning(s)" message
   - If errors appear, ensure you copied the complete file

## Step 4: Attach EA to Chart

1. **Open a chart**:
   - In MT5, open a chart for your desired symbol
   - Recommended: EUR/USD or BTC/USD on M15 timeframe
2. **Enable Auto Trading**:
   - Click the "Auto Trading" button in MT5 toolbar (should be green)
   - Or press `Ctrl+E`
3. **Add the EA**:
   - In Navigator panel (`Ctrl+N`), expand "Expert Advisors"
   - Find `AI_Trader`
   - Drag and drop it onto your chart
4. **Configure** (or use defaults):
   - A settings window will appear
   - For your first try, use these conservative settings:
     ```
     RiskPercent = 0.5
     ConfidenceThreshold = 0.75
     MaxOpenTrades = 2
     MaxDailyDrawdown = 3.0
     ```
   - Click "OK"

## Step 5: Verify It's Running

You should see:
- A smiling face emoji 😊 in the top-right corner of the chart
- The EA name "AI_Trader" displayed
- Messages in the "Experts" tab at the bottom of MT5

✅ **Success!** The AI Trader is now running!

---

## Recommended First Settings

### For Demo Testing (Conservative)

```
=== AI & Machine Learning Settings ===
ConfidenceThreshold = 0.75

=== Risk Management ===
RiskPercent = 0.5
MaxDailyDrawdown = 3.0
MaxOpenTrades = 2

=== Market Type Settings ===
TradeCrypto = false
TradeForex = true
```

**Start with**: EUR/USD on M15 timeframe

### Monitor These Things

1. **Check Experts tab** for EA messages
2. **Watch for trades** being opened (check "Trade" tab)
3. **Monitor account balance** and equity
4. **Review daily** for the first week

---

## Quick Troubleshooting

### ❌ EA shows sad face 😢
**Solution**: Auto Trading is disabled. Click the Auto Trading button (or press Ctrl+E)

### ❌ "AI Trader not initialized"
**Solution**: 
- Check Experts tab for error messages
- Ensure symbol has sufficient historical data
- Try restarting MT5

### ❌ No trades opening
**Possible causes**:
1. Confidence threshold too high → Lower to 0.65
2. No clear market signals → Wait for better conditions
3. Daily drawdown limit reached → Check daily profit/loss
4. Max trades limit reached → Wait for trades to close

### ❌ "Cannot open trade" errors
**Solution**:
- Check if you have sufficient margin
- Verify your broker allows EA trading
- Ensure market is open (check trading hours)

---

## What Happens Next?

### First 24 Hours
- EA will analyze the market every bar
- It will learn market patterns
- May open 0-3 trades depending on conditions
- Check the Experts tab for AI confidence scores

### First Week
- Monitor performance daily
- Review win rate and profit/loss
- Adjust settings if needed
- Keep a trading journal

### After 2 Weeks
- If profitable on demo, consider increasing risk slightly
- If losing, lower confidence threshold or risk percent
- Re-optimize parameters using Strategy Tester
- Consider testing on different pairs

---

## Next Steps

### 1. Backtest Your Settings

1. Open Strategy Tester (`Ctrl+R`)
2. Select `AI_Trader`
3. Choose your symbol and timeframe
4. Set date range (6-12 months)
5. Click "Start"
6. Review results

**Good results**: Win rate > 50%, Profit Factor > 1.5, Drawdown < 20%

### 2. Read Full Documentation

- **[USER_GUIDE.md](USER_GUIDE.md)** - Complete usage guide
- **[CONFIGURATION_EXAMPLES.md](CONFIGURATION_EXAMPLES.md)** - Pre-configured setups
- **[ARCHITECTURE.md](ARCHITECTURE.md)** - Technical details

### 3. Optimize Parameters

1. In Strategy Tester, click "Optimization"
2. Select parameters to optimize:
   - ConfidenceThreshold (0.55 to 0.80, step 0.05)
   - RiskPercent (0.5 to 2.0, step 0.25)
3. Choose "Balance" or "Sharpe Ratio" criterion
4. Start optimization
5. Use best parameters from results

### 4. Advanced Configuration

Try different strategies from `CONFIGURATION_EXAMPLES.md`:
- Conservative Forex Trader
- Aggressive Crypto Trader
- Scalping Strategy
- Swing Trading Strategy

---

## Safety Checklist

Before going live with real money:

- [ ] Backtested on 6+ months of historical data
- [ ] Forward tested on demo account for 2+ weeks
- [ ] Understand all risk parameters
- [ ] Set appropriate MaxDailyDrawdown (≤5%)
- [ ] Start with minimum risk (0.5% or less)
- [ ] Have monitoring system in place
- [ ] Understand how to stop the EA if needed

---

## Emergency Stop

If you need to stop the EA immediately:

1. **Method 1**: Click "Auto Trading" button (turns red)
2. **Method 2**: Remove EA from chart (right-click chart → Expert Advisors → Remove)
3. **Method 3**: Close MT5 platform

To close all open positions:
- Right-click in "Trade" tab → "Close All"

---

## Support

Need help?

- 📖 Check [USER_GUIDE.md](USER_GUIDE.md) for detailed instructions
- 🐛 Report bugs on [GitHub Issues](https://github.com/korre21aek/EA-Trader-1/issues)
- 💬 Ask questions in [GitHub Discussions](https://github.com/korre21aek/EA-Trader-1/discussions)

---

## Quick Reference Card

### Essential Keyboard Shortcuts
- `F4` - Open MetaEditor
- `F7` - Compile EA
- `Ctrl+R` - Open Strategy Tester
- `Ctrl+E` - Toggle Auto Trading
- `Ctrl+N` - Show Navigator

### Default Parameters (Quick Reference)
| Setting | Default | Conservative | Aggressive |
|---------|---------|--------------|------------|
| Risk % | 1.0 | 0.5 | 2.0 |
| Confidence | 0.65 | 0.75 | 0.60 |
| Max Trades | 3 | 2 | 5 |
| Daily DD % | 5.0 | 3.0 | 7.0 |

### Recommended Timeframes
- **Scalping**: M1, M5, M15
- **Day Trading**: M15, H1, H4 ⭐ (Recommended)
- **Swing Trading**: H4, D1, W1

### Best Currency Pairs to Start
- **Forex**: EUR/USD, GBP/USD, USD/JPY
- **Crypto**: BTC/USD, ETH/USD

---

## Tips for Success

✅ **Do**:
- Start with demo account
- Use conservative settings initially
- Monitor performance regularly
- Keep a trading journal
- Backtest before going live
- Use proper risk management

❌ **Don't**:
- Risk more than 2% per trade
- Trade without backtesting
- Leave EA completely unattended
- Disable stop losses
- Ignore daily drawdown limits
- Make changes during active trades

---

## Summary

**5-Minute Setup**:
1. ✅ Install MT5
2. ✅ Copy EA file to MQL5/Experts folder
3. ✅ Compile in MetaEditor (F7)
4. ✅ Drag EA onto chart
5. ✅ Enable Auto Trading (Ctrl+E)

**You're done!** The AI Trader is now analyzing the market and will trade when it finds high-confidence opportunities.

---

**Good luck with your AI-powered trading! 🚀📈**

Remember: Start small, test thoroughly, and always use proper risk management!
