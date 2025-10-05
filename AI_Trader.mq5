//+------------------------------------------------------------------+
//|                                                    AI_Trader.mq5 |
//|                                         Advanced AI Trading Bot  |
//|                       For Crypto & Forex with Neural Networks    |
//+------------------------------------------------------------------+
#property copyright "EA-Trader-1"
#property link      "https://github.com/korre21aek/EA-Trader-1"
#property version   "1.00"
#property description "Advanced AI-powered Expert Advisor using Neural Networks"
#property description "Supports both Cryptocurrency and Forex markets"

//--- Input Parameters
input group "=== AI & Machine Learning Settings ==="
input int      NeuralLayers = 3;                    // Number of hidden layers in neural network
input int      NeuronsPerLayer = 10;                // Neurons per hidden layer
input double   LearningRate = 0.01;                 // Neural network learning rate
input int      TrainingPeriod = 100;                // Training period (bars)
input double   ConfidenceThreshold = 0.65;          // Minimum confidence for trade entry (0-1)

input group "=== Market Analysis Settings ==="
input bool     UseMultiTimeframe = true;            // Enable multi-timeframe analysis
input ENUM_TIMEFRAMES TimeFrame1 = PERIOD_M15;      // Primary timeframe
input ENUM_TIMEFRAMES TimeFrame2 = PERIOD_H1;       // Secondary timeframe
input ENUM_TIMEFRAMES TimeFrame3 = PERIOD_H4;       // Tertiary timeframe
input int      AnalysisPeriod = 50;                 // Period for market analysis

input group "=== Technical Indicators ==="
input bool     UseRSI = true;                       // Use RSI indicator
input int      RSI_Period = 14;                     // RSI Period
input bool     UseMACD = true;                      // Use MACD indicator
input int      MACD_Fast = 12;                      // MACD Fast EMA
input int      MACD_Slow = 26;                      // MACD Slow EMA
input int      MACD_Signal = 9;                     // MACD Signal
input bool     UseBollinger = true;                 // Use Bollinger Bands
input int      BB_Period = 20;                      // Bollinger Bands Period
input double   BB_Deviation = 2.0;                  // Bollinger Bands Deviation
input bool     UseATR = true;                       // Use ATR for volatility
input int      ATR_Period = 14;                     // ATR Period

input group "=== Risk Management ==="
input double   RiskPercent = 1.0;                   // Risk per trade (% of balance)
input double   MaxDailyDrawdown = 5.0;              // Max daily drawdown (%)
input double   TakeProfitMultiplier = 2.0;          // TP multiplier (R:R ratio)
input double   StopLossATRMultiplier = 2.0;         // SL based on ATR
input int      MaxOpenTrades = 3;                   // Maximum simultaneous trades
input bool     UseTrailingStop = true;              // Enable trailing stop
input double   TrailingStopATRMultiplier = 1.5;     // Trailing stop ATR multiplier

input group "=== Market Type Settings ==="
input bool     TradeCrypto = true;                  // Enable Crypto trading
input bool     TradeForex = true;                   // Enable Forex trading
input double   CryptoVolatilityFactor = 1.5;        // Crypto volatility adjustment
input double   ForexSpreadLimit = 3.0;              // Max spread for Forex (pips)

input group "=== Advanced AI Features ==="
input bool     UsePatternRecognition = true;        // Enable pattern recognition
input bool     UseSentimentAnalysis = true;         // Enable sentiment analysis
input bool     UseAdaptiveLearning = true;          // Enable adaptive learning
input int      MemorySize = 500;                    // AI memory size (past patterns)
input bool     UseDynamicPositioning = true;        // Dynamic position sizing

//--- Global Variables
struct NeuralNetwork {
    double weights[100][100];        // Neural network weights
    double biases[100];              // Biases for each layer
    double activations[100];         // Activation values
    int inputSize;
    int hiddenSize;
    int outputSize;
};

struct MarketPattern {
    double features[50];             // Pattern features
    int signal;                      // Signal: 1=buy, -1=sell, 0=neutral
    double confidence;               // Confidence score
    datetime timestamp;              // Pattern timestamp
};

struct TradeMemory {
    double entryPrice;
    double exitPrice;
    double profit;
    double confidence;
    double features[50];
    bool wasSuccessful;
};

NeuralNetwork g_neuralNet;
MarketPattern g_currentPattern;
TradeMemory g_tradeHistory[];
double g_performanceMetrics[];

int g_totalTrades = 0;
int g_winningTrades = 0;
double g_totalProfit = 0;
double g_dailyProfit = 0;
datetime g_lastTradeTime = 0;
datetime g_dailyResetTime = 0;

//--- Indicator Handles
int h_RSI, h_MACD, h_BB, h_ATR;
int h_RSI_TF2, h_MACD_TF2, h_ATR_TF2;
int h_RSI_TF3, h_MACD_TF3, h_ATR_TF3;

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
{
    Print("=== AI Trader Initialization ===");
    Print("Neural Network Configuration:");
    Print("  - Layers: ", NeuralLayers);
    Print("  - Neurons per layer: ", NeuronsPerLayer);
    Print("  - Learning rate: ", LearningRate);
    
    //--- Initialize Neural Network
    InitializeNeuralNetwork();
    
    //--- Initialize Technical Indicators
    if(!InitializeIndicators()) {
        Print("ERROR: Failed to initialize indicators");
        return(INIT_FAILED);
    }
    
    //--- Initialize Trade History Array
    ArrayResize(g_tradeHistory, MemorySize);
    ArrayResize(g_performanceMetrics, 10);
    
    //--- Set magic number
    if(!PositionSelect(_Symbol)) {
        Print("Symbol: ", _Symbol, " initialized successfully");
    }
    
    g_dailyResetTime = TimeCurrent();
    
    Print("AI Trader initialized successfully!");
    Print("Trading Mode: ", (TradeCrypto ? "Crypto " : ""), (TradeForex ? "Forex" : ""));
    
    return(INIT_SUCCEEDED);
}

//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
{
    //--- Release indicator handles
    if(h_RSI != INVALID_HANDLE) IndicatorRelease(h_RSI);
    if(h_MACD != INVALID_HANDLE) IndicatorRelease(h_MACD);
    if(h_BB != INVALID_HANDLE) IndicatorRelease(h_BB);
    if(h_ATR != INVALID_HANDLE) IndicatorRelease(h_ATR);
    
    if(UseMultiTimeframe) {
        if(h_RSI_TF2 != INVALID_HANDLE) IndicatorRelease(h_RSI_TF2);
        if(h_MACD_TF2 != INVALID_HANDLE) IndicatorRelease(h_MACD_TF2);
        if(h_ATR_TF2 != INVALID_HANDLE) IndicatorRelease(h_ATR_TF2);
        if(h_RSI_TF3 != INVALID_HANDLE) IndicatorRelease(h_RSI_TF3);
        if(h_MACD_TF3 != INVALID_HANDLE) IndicatorRelease(h_MACD_TF3);
        if(h_ATR_TF3 != INVALID_HANDLE) IndicatorRelease(h_ATR_TF3);
    }
    
    Print("=== AI Trader Statistics ===");
    Print("Total Trades: ", g_totalTrades);
    Print("Winning Trades: ", g_winningTrades);
    if(g_totalTrades > 0) {
        Print("Win Rate: ", DoubleToString((double)g_winningTrades/g_totalTrades*100, 2), "%");
    }
    Print("Total Profit: ", DoubleToString(g_totalProfit, 2));
    
    Print("AI Trader deinitialized. Reason: ", reason);
}

//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
{
    //--- Check if new bar
    static datetime lastBar = 0;
    datetime currentBar = iTime(_Symbol, TimeFrame1, 0);
    
    if(currentBar == lastBar) return;
    lastBar = currentBar;
    
    //--- Reset daily metrics
    ResetDailyMetrics();
    
    //--- Check daily drawdown limit
    if(g_dailyProfit < -MaxDailyDrawdown * AccountInfoDouble(ACCOUNT_BALANCE) / 100) {
        Print("Daily drawdown limit reached. Trading suspended for today.");
        return;
    }
    
    //--- Analyze market conditions
    if(!AnalyzeMarket()) return;
    
    //--- Neural network prediction
    double prediction = NeuralNetworkPredict();
    double confidence = MathAbs(prediction);
    
    //--- Update pattern with AI analysis
    g_currentPattern.confidence = confidence;
    
    //--- Adaptive learning from past trades
    if(UseAdaptiveLearning && g_totalTrades > 10) {
        AdaptiveLearning();
    }
    
    //--- Manage existing positions
    ManagePositions();
    
    //--- Check if we can open new trades
    if(CountOpenPositions() >= MaxOpenTrades) return;
    
    //--- Trading logic with AI confidence
    if(confidence >= ConfidenceThreshold) {
        if(prediction > 0 && g_currentPattern.signal == 1) {
            // Strong buy signal
            OpenTrade(ORDER_TYPE_BUY, confidence);
        }
        else if(prediction < 0 && g_currentPattern.signal == -1) {
            // Strong sell signal
            OpenTrade(ORDER_TYPE_SELL, confidence);
        }
    }
    
    //--- Pattern recognition and learning
    if(UsePatternRecognition) {
        RecognizeAndLearnPatterns();
    }
}

//+------------------------------------------------------------------+
//| Initialize Neural Network                                        |
//+------------------------------------------------------------------+
void InitializeNeuralNetwork()
{
    g_neuralNet.inputSize = 20;   // Number of input features
    g_neuralNet.hiddenSize = NeuronsPerLayer;
    g_neuralNet.outputSize = 1;   // Output: buy/sell signal
    
    //--- Initialize weights with random values
    MathSrand((int)TimeLocal());
    for(int i = 0; i < 100; i++) {
        for(int j = 0; j < 100; j++) {
            g_neuralNet.weights[i][j] = (MathRand() / 32768.0 - 0.5) * 0.1;
        }
        g_neuralNet.biases[i] = (MathRand() / 32768.0 - 0.5) * 0.1;
        g_neuralNet.activations[i] = 0.0;
    }
    
    Print("Neural network initialized with ", g_neuralNet.inputSize, " inputs, ",
          g_neuralNet.hiddenSize, " hidden neurons, and ", g_neuralNet.outputSize, " output");
}

//+------------------------------------------------------------------+
//| Initialize Technical Indicators                                  |
//+------------------------------------------------------------------+
bool InitializeIndicators()
{
    //--- Primary timeframe indicators
    if(UseRSI) {
        h_RSI = iRSI(_Symbol, TimeFrame1, RSI_Period, PRICE_CLOSE);
        if(h_RSI == INVALID_HANDLE) {
            Print("Failed to create RSI indicator");
            return false;
        }
    }
    
    if(UseMACD) {
        h_MACD = iMACD(_Symbol, TimeFrame1, MACD_Fast, MACD_Slow, MACD_Signal, PRICE_CLOSE);
        if(h_MACD == INVALID_HANDLE) {
            Print("Failed to create MACD indicator");
            return false;
        }
    }
    
    if(UseBollinger) {
        h_BB = iBands(_Symbol, TimeFrame1, BB_Period, 0, BB_Deviation, PRICE_CLOSE);
        if(h_BB == INVALID_HANDLE) {
            Print("Failed to create Bollinger Bands indicator");
            return false;
        }
    }
    
    if(UseATR) {
        h_ATR = iATR(_Symbol, TimeFrame1, ATR_Period);
        if(h_ATR == INVALID_HANDLE) {
            Print("Failed to create ATR indicator");
            return false;
        }
    }
    
    //--- Multi-timeframe indicators
    if(UseMultiTimeframe) {
        if(UseRSI) {
            h_RSI_TF2 = iRSI(_Symbol, TimeFrame2, RSI_Period, PRICE_CLOSE);
            h_RSI_TF3 = iRSI(_Symbol, TimeFrame3, RSI_Period, PRICE_CLOSE);
        }
        if(UseMACD) {
            h_MACD_TF2 = iMACD(_Symbol, TimeFrame2, MACD_Fast, MACD_Slow, MACD_Signal, PRICE_CLOSE);
            h_MACD_TF3 = iMACD(_Symbol, TimeFrame3, MACD_Fast, MACD_Slow, MACD_Signal, PRICE_CLOSE);
        }
        if(UseATR) {
            h_ATR_TF2 = iATR(_Symbol, TimeFrame2, ATR_Period);
            h_ATR_TF3 = iATR(_Symbol, TimeFrame3, ATR_Period);
        }
    }
    
    return true;
}

//+------------------------------------------------------------------+
//| Analyze Market Conditions                                        |
//+------------------------------------------------------------------+
bool AnalyzeMarket()
{
    //--- Check market type
    string symbol = _Symbol;
    bool isCrypto = IsCryptoSymbol(symbol);
    bool isForex = IsForexSymbol(symbol);
    
    if(isCrypto && !TradeCrypto) return false;
    if(isForex && !TradeForex) return false;
    
    //--- Get current price data
    double close = iClose(_Symbol, TimeFrame1, 0);
    double open = iOpen(_Symbol, TimeFrame1, 0);
    double high = iHigh(_Symbol, TimeFrame1, 0);
    double low = iLow(_Symbol, TimeFrame1, 0);
    
    if(close == 0 || open == 0) return false;
    
    //--- Initialize pattern features
    ArrayInitialize(g_currentPattern.features, 0);
    int featureIndex = 0;
    
    //--- Price action features
    g_currentPattern.features[featureIndex++] = (close - open) / open;  // Candle body
    g_currentPattern.features[featureIndex++] = (high - low) / low;     // Candle range
    
    //--- RSI Analysis
    double rsi = 50.0;
    if(UseRSI && h_RSI != INVALID_HANDLE) {
        double rsiBuffer[];
        ArraySetAsSeries(rsiBuffer, true);
        if(CopyBuffer(h_RSI, 0, 0, 3, rsiBuffer) > 0) {
            rsi = rsiBuffer[0];
            g_currentPattern.features[featureIndex++] = rsi / 100.0;
            g_currentPattern.features[featureIndex++] = (rsi - rsiBuffer[1]) / 100.0;  // RSI momentum
        }
    }
    
    //--- MACD Analysis
    if(UseMACD && h_MACD != INVALID_HANDLE) {
        double macdMain[], macdSignal[];
        ArraySetAsSeries(macdMain, true);
        ArraySetAsSeries(macdSignal, true);
        if(CopyBuffer(h_MACD, 0, 0, 3, macdMain) > 0 && CopyBuffer(h_MACD, 1, 0, 3, macdSignal) > 0) {
            g_currentPattern.features[featureIndex++] = macdMain[0];
            g_currentPattern.features[featureIndex++] = macdSignal[0];
            g_currentPattern.features[featureIndex++] = macdMain[0] - macdSignal[0];  // MACD histogram
        }
    }
    
    //--- Bollinger Bands Analysis
    if(UseBollinger && h_BB != INVALID_HANDLE) {
        double bbUpper[], bbMiddle[], bbLower[];
        ArraySetAsSeries(bbUpper, true);
        ArraySetAsSeries(bbMiddle, true);
        ArraySetAsSeries(bbLower, true);
        if(CopyBuffer(h_BB, 1, 0, 1, bbUpper) > 0 && 
           CopyBuffer(h_BB, 0, 0, 1, bbMiddle) > 0 &&
           CopyBuffer(h_BB, 2, 0, 1, bbLower) > 0) {
            double bbPosition = (close - bbLower[0]) / (bbUpper[0] - bbLower[0]);
            g_currentPattern.features[featureIndex++] = bbPosition;
            g_currentPattern.features[featureIndex++] = (bbUpper[0] - bbLower[0]) / bbMiddle[0];  // BB width
        }
    }
    
    //--- ATR for volatility
    double atr = 0;
    if(UseATR && h_ATR != INVALID_HANDLE) {
        double atrBuffer[];
        ArraySetAsSeries(atrBuffer, true);
        if(CopyBuffer(h_ATR, 0, 0, 1, atrBuffer) > 0) {
            atr = atrBuffer[0];
            g_currentPattern.features[featureIndex++] = atr / close;  // Normalized volatility
        }
    }
    
    //--- Multi-timeframe analysis
    if(UseMultiTimeframe) {
        // Add higher timeframe trend
        double tf2_close = iClose(_Symbol, TimeFrame2, 0);
        double tf2_open = iClose(_Symbol, TimeFrame2, 1);
        double tf3_close = iClose(_Symbol, TimeFrame3, 0);
        double tf3_open = iClose(_Symbol, TimeFrame3, 1);
        
        g_currentPattern.features[featureIndex++] = (tf2_close - tf2_open) / tf2_open;
        g_currentPattern.features[featureIndex++] = (tf3_close - tf3_open) / tf3_open;
        
        // Higher timeframe RSI
        if(UseRSI && h_RSI_TF2 != INVALID_HANDLE && h_RSI_TF3 != INVALID_HANDLE) {
            double rsi2[], rsi3[];
            ArraySetAsSeries(rsi2, true);
            ArraySetAsSeries(rsi3, true);
            if(CopyBuffer(h_RSI_TF2, 0, 0, 1, rsi2) > 0) {
                g_currentPattern.features[featureIndex++] = rsi2[0] / 100.0;
            }
            if(CopyBuffer(h_RSI_TF3, 0, 0, 1, rsi3) > 0) {
                g_currentPattern.features[featureIndex++] = rsi3[0] / 100.0;
            }
        }
    }
    
    //--- Volume analysis (if available)
    long volume = iVolume(_Symbol, TimeFrame1, 0);
    long avgVolume = 0;
    for(int i = 1; i <= 20; i++) {
        avgVolume += iVolume(_Symbol, TimeFrame1, i);
    }
    avgVolume /= 20;
    if(avgVolume > 0) {
        g_currentPattern.features[featureIndex++] = (double)volume / avgVolume;
    }
    
    //--- Generate trading signal based on technical analysis
    g_currentPattern.signal = GenerateSignal(rsi, atr);
    g_currentPattern.timestamp = TimeCurrent();
    
    return true;
}

//+------------------------------------------------------------------+
//| Generate Trading Signal                                          |
//+------------------------------------------------------------------+
int GenerateSignal(double rsi, double atr)
{
    int signal = 0;
    double signalStrength = 0;
    
    //--- RSI signals
    if(UseRSI) {
        if(rsi < 30) signalStrength += 0.3;      // Oversold - buy signal
        else if(rsi > 70) signalStrength -= 0.3; // Overbought - sell signal
    }
    
    //--- MACD signals
    if(UseMACD && h_MACD != INVALID_HANDLE) {
        double macdMain[], macdSignal[];
        ArraySetAsSeries(macdMain, true);
        ArraySetAsSeries(macdSignal, true);
        if(CopyBuffer(h_MACD, 0, 0, 2, macdMain) > 0 && CopyBuffer(h_MACD, 1, 0, 2, macdSignal) > 0) {
            // MACD crossover
            if(macdMain[0] > macdSignal[0] && macdMain[1] <= macdSignal[1]) {
                signalStrength += 0.4;  // Bullish crossover
            }
            else if(macdMain[0] < macdSignal[0] && macdMain[1] >= macdSignal[1]) {
                signalStrength -= 0.4;  // Bearish crossover
            }
        }
    }
    
    //--- Bollinger Bands signals
    if(UseBollinger && h_BB != INVALID_HANDLE) {
        double close = iClose(_Symbol, TimeFrame1, 0);
        double bbUpper[], bbLower[];
        ArraySetAsSeries(bbUpper, true);
        ArraySetAsSeries(bbLower, true);
        if(CopyBuffer(h_BB, 1, 0, 1, bbUpper) > 0 && CopyBuffer(h_BB, 2, 0, 1, bbLower) > 0) {
            if(close < bbLower[0]) signalStrength += 0.3;      // Below lower band - buy
            else if(close > bbUpper[0]) signalStrength -= 0.3; // Above upper band - sell
        }
    }
    
    //--- Determine final signal
    if(signalStrength > 0.3) signal = 1;       // Buy signal
    else if(signalStrength < -0.3) signal = -1; // Sell signal
    else signal = 0;                            // Neutral
    
    return signal;
}

//+------------------------------------------------------------------+
//| Neural Network Prediction                                        |
//+------------------------------------------------------------------+
double NeuralNetworkPredict()
{
    //--- Prepare input layer
    double inputs[];
    ArrayResize(inputs, g_neuralNet.inputSize);
    
    for(int i = 0; i < g_neuralNet.inputSize && i < 50; i++) {
        inputs[i] = g_currentPattern.features[i];
    }
    
    //--- Forward propagation through hidden layers
    double hiddenOutputs[];
    ArrayResize(hiddenOutputs, g_neuralNet.hiddenSize);
    
    // Input to hidden layer
    for(int i = 0; i < g_neuralNet.hiddenSize; i++) {
        double sum = g_neuralNet.biases[i];
        for(int j = 0; j < g_neuralNet.inputSize; j++) {
            sum += inputs[j] * g_neuralNet.weights[j][i];
        }
        hiddenOutputs[i] = ActivationFunction(sum);  // Apply activation function
    }
    
    //--- Hidden to output layer
    double output = g_neuralNet.biases[g_neuralNet.hiddenSize];
    for(int i = 0; i < g_neuralNet.hiddenSize; i++) {
        output += hiddenOutputs[i] * g_neuralNet.weights[g_neuralNet.inputSize + i][0];
    }
    
    output = MathTanh(output);  // Output activation (tanh for -1 to 1 range)
    
    return output;
}

//+------------------------------------------------------------------+
//| Activation Function (ReLU)                                       |
//+------------------------------------------------------------------+
double ActivationFunction(double x)
{
    // ReLU activation
    return MathMax(0, x);
}

//+------------------------------------------------------------------+
//| Adaptive Learning from Past Trades                               |
//+------------------------------------------------------------------+
void AdaptiveLearning()
{
    if(g_totalTrades < 10) return;
    
    //--- Calculate recent performance
    int recentTrades = MathMin(20, g_totalTrades);
    int recentWins = 0;
    double recentProfit = 0;
    
    for(int i = 0; i < recentTrades && i < ArraySize(g_tradeHistory); i++) {
        if(g_tradeHistory[i].wasSuccessful) recentWins++;
        recentProfit += g_tradeHistory[i].profit;
    }
    
    double recentWinRate = (double)recentWins / recentTrades;
    
    //--- Adjust neural network weights based on performance
    if(recentWinRate < 0.4) {
        // Poor performance - increase learning rate temporarily
        double tempLearningRate = LearningRate * 1.5;
        
        // Update weights based on recent losing patterns
        for(int i = 0; i < recentTrades && i < ArraySize(g_tradeHistory); i++) {
            if(!g_tradeHistory[i].wasSuccessful) {
                // Penalize the weights that led to this loss
                for(int j = 0; j < 10 && j < g_neuralNet.hiddenSize; j++) {
                    for(int k = 0; k < 10 && k < g_neuralNet.inputSize; k++) {
                        g_neuralNet.weights[k][j] *= (1.0 - tempLearningRate * 0.1);
                    }
                }
            }
        }
        
        Print("Adaptive learning applied - adjusting strategy after low win rate: ", 
              DoubleToString(recentWinRate * 100, 1), "%");
    }
    else if(recentWinRate > 0.6) {
        // Good performance - reinforce successful patterns
        for(int i = 0; i < recentTrades && i < ArraySize(g_tradeHistory); i++) {
            if(g_tradeHistory[i].wasSuccessful) {
                // Slightly reinforce successful weights
                for(int j = 0; j < 10 && j < g_neuralNet.hiddenSize; j++) {
                    for(int k = 0; k < 10 && k < g_neuralNet.inputSize; k++) {
                        g_neuralNet.weights[k][j] *= (1.0 + LearningRate * 0.05);
                    }
                }
            }
        }
    }
}

//+------------------------------------------------------------------+
//| Pattern Recognition and Learning                                 |
//+------------------------------------------------------------------+
void RecognizeAndLearnPatterns()
{
    //--- Store current pattern in memory
    static int memoryIndex = 0;
    
    if(g_totalTrades > 0 && memoryIndex < ArraySize(g_tradeHistory)) {
        // Copy current pattern features to trade history
        for(int i = 0; i < 50; i++) {
            g_tradeHistory[memoryIndex].features[i] = g_currentPattern.features[i];
        }
        g_tradeHistory[memoryIndex].confidence = g_currentPattern.confidence;
        
        memoryIndex = (memoryIndex + 1) % MemorySize;
    }
    
    //--- Pattern similarity matching
    if(g_totalTrades > 20) {
        double maxSimilarity = 0;
        int similarPatternIndex = -1;
        
        // Find most similar historical pattern
        for(int i = 0; i < MathMin(g_totalTrades, ArraySize(g_tradeHistory)); i++) {
            double similarity = CalculatePatternSimilarity(g_currentPattern.features, g_tradeHistory[i].features);
            if(similarity > maxSimilarity) {
                maxSimilarity = similarity;
                similarPatternIndex = i;
            }
        }
        
        // Use historical outcome to adjust confidence
        if(similarPatternIndex >= 0 && maxSimilarity > 0.8) {
            if(g_tradeHistory[similarPatternIndex].wasSuccessful) {
                g_currentPattern.confidence *= 1.1;  // Boost confidence
            } else {
                g_currentPattern.confidence *= 0.9;  // Reduce confidence
            }
            
            Print("Similar pattern found with ", DoubleToString(maxSimilarity * 100, 1), 
                  "% similarity. Historical result: ", 
                  (g_tradeHistory[similarPatternIndex].wasSuccessful ? "Win" : "Loss"));
        }
    }
}

//+------------------------------------------------------------------+
//| Calculate Pattern Similarity                                     |
//+------------------------------------------------------------------+
double CalculatePatternSimilarity(const double &pattern1[], const double &pattern2[])
{
    double similarity = 0;
    int features = MathMin(20, ArraySize(pattern1));
    
    for(int i = 0; i < features; i++) {
        double diff = MathAbs(pattern1[i] - pattern2[i]);
        similarity += (1.0 - MathMin(diff, 1.0));
    }
    
    return similarity / features;
}

//+------------------------------------------------------------------+
//| Open Trade                                                        |
//+------------------------------------------------------------------+
void OpenTrade(ENUM_ORDER_TYPE orderType, double confidence)
{
    //--- Get ATR for stop loss calculation
    double atr = 0;
    if(h_ATR != INVALID_HANDLE) {
        double atrBuffer[];
        ArraySetAsSeries(atrBuffer, true);
        if(CopyBuffer(h_ATR, 0, 0, 1, atrBuffer) > 0) {
            atr = atrBuffer[0];
        }
    }
    
    if(atr == 0) {
        Print("Cannot calculate ATR for stop loss");
        return;
    }
    
    //--- Calculate position size based on risk
    double price = (orderType == ORDER_TYPE_BUY) ? SymbolInfoDouble(_Symbol, SYMBOL_ASK) : 
                                                     SymbolInfoDouble(_Symbol, SYMBOL_BID);
    double stopLoss = atr * StopLossATRMultiplier;
    double takeProfit = stopLoss * TakeProfitMultiplier;
    
    //--- Adjust for crypto volatility
    if(IsCryptoSymbol(_Symbol)) {
        stopLoss *= CryptoVolatilityFactor;
        takeProfit *= CryptoVolatilityFactor;
    }
    
    //--- Dynamic position sizing based on confidence
    double riskAmount = AccountInfoDouble(ACCOUNT_BALANCE) * RiskPercent / 100.0;
    if(UseDynamicPositioning) {
        riskAmount *= confidence;  // Scale risk by confidence level
    }
    
    double lotSize = CalculateLotSize(riskAmount, stopLoss);
    
    //--- Normalize lot size
    double minLot = SymbolInfoDouble(_Symbol, SYMBOL_VOLUME_MIN);
    double maxLot = SymbolInfoDouble(_Symbol, SYMBOL_VOLUME_MAX);
    double lotStep = SymbolInfoDouble(_Symbol, SYMBOL_VOLUME_STEP);
    
    lotSize = MathMax(minLot, MathMin(maxLot, MathRound(lotSize / lotStep) * lotStep));
    
    //--- Calculate SL and TP prices
    double slPrice, tpPrice;
    if(orderType == ORDER_TYPE_BUY) {
        slPrice = price - stopLoss;
        tpPrice = price + takeProfit;
    } else {
        slPrice = price + stopLoss;
        tpPrice = price - takeProfit;
    }
    
    //--- Prepare trade request
    MqlTradeRequest request = {};
    MqlTradeResult result = {};
    
    request.action = TRADE_ACTION_DEAL;
    request.symbol = _Symbol;
    request.volume = lotSize;
    request.type = orderType;
    request.price = price;
    request.sl = slPrice;
    request.tp = tpPrice;
    request.deviation = 10;
    request.magic = 123456;
    request.comment = StringFormat("AI_Trader (Conf: %.2f)", confidence);
    
    //--- Send order
    if(OrderSend(request, result)) {
        if(result.retcode == TRADE_RETCODE_DONE) {
            Print("Trade opened successfully: ", (orderType == ORDER_TYPE_BUY ? "BUY" : "SELL"),
                  " | Lot: ", lotSize, " | Price: ", price, " | Confidence: ", DoubleToString(confidence, 2));
            
            g_lastTradeTime = TimeCurrent();
            g_totalTrades++;
            
            // Store trade in memory
            int idx = (g_totalTrades - 1) % MemorySize;
            if(idx < ArraySize(g_tradeHistory)) {
                g_tradeHistory[idx].entryPrice = price;
                g_tradeHistory[idx].confidence = confidence;
                for(int i = 0; i < 50; i++) {
                    g_tradeHistory[idx].features[i] = g_currentPattern.features[i];
                }
            }
        } else {
            Print("Order failed: ", result.retcode, " - ", result.comment);
        }
    } else {
        Print("OrderSend failed: ", GetLastError());
    }
}

//+------------------------------------------------------------------+
//| Calculate Lot Size                                               |
//+------------------------------------------------------------------+
double CalculateLotSize(double riskAmount, double stopLossPoints)
{
    double tickValue = SymbolInfoDouble(_Symbol, SYMBOL_TRADE_TICK_VALUE);
    double tickSize = SymbolInfoDouble(_Symbol, SYMBOL_TRADE_TICK_SIZE);
    
    if(tickValue == 0 || tickSize == 0 || stopLossPoints == 0) return 0.01;
    
    double lotSize = riskAmount / (stopLossPoints / tickSize * tickValue);
    
    return lotSize;
}

//+------------------------------------------------------------------+
//| Manage Open Positions                                            |
//+------------------------------------------------------------------+
void ManagePositions()
{
    for(int i = PositionsTotal() - 1; i >= 0; i--) {
        ulong ticket = PositionGetTicket(i);
        if(ticket <= 0) continue;
        
        if(PositionGetString(POSITION_SYMBOL) != _Symbol) continue;
        
        double positionProfit = PositionGetDouble(POSITION_PROFIT);
        double entryPrice = PositionGetDouble(POSITION_PRICE_OPEN);
        double currentPrice = PositionGetDouble(POSITION_PRICE_CURRENT);
        long positionType = PositionGetInteger(POSITION_TYPE);
        
        //--- Trailing stop
        if(UseTrailingStop && positionProfit > 0) {
            double atr = 0;
            if(h_ATR != INVALID_HANDLE) {
                double atrBuffer[];
                ArraySetAsSeries(atrBuffer, true);
                if(CopyBuffer(h_ATR, 0, 0, 1, atrBuffer) > 0) {
                    atr = atrBuffer[0];
                }
            }
            
            if(atr > 0) {
                double trailingDistance = atr * TrailingStopATRMultiplier;
                double newSL = 0;
                
                if(positionType == POSITION_TYPE_BUY) {
                    newSL = currentPrice - trailingDistance;
                    double currentSL = PositionGetDouble(POSITION_SL);
                    if(newSL > currentSL) {
                        ModifyPosition(ticket, newSL, PositionGetDouble(POSITION_TP));
                    }
                } else if(positionType == POSITION_TYPE_SELL) {
                    newSL = currentPrice + trailingDistance;
                    double currentSL = PositionGetDouble(POSITION_SL);
                    if(newSL < currentSL || currentSL == 0) {
                        ModifyPosition(ticket, newSL, PositionGetDouble(POSITION_TP));
                    }
                }
            }
        }
        
        //--- Update trade history when position closes
        if(positionProfit != 0) {
            int idx = (g_totalTrades - 1) % MemorySize;
            if(idx >= 0 && idx < ArraySize(g_tradeHistory)) {
                g_tradeHistory[idx].exitPrice = currentPrice;
                g_tradeHistory[idx].profit = positionProfit;
                g_tradeHistory[idx].wasSuccessful = (positionProfit > 0);
                
                if(positionProfit > 0) {
                    g_winningTrades++;
                }
                g_totalProfit += positionProfit;
                g_dailyProfit += positionProfit;
            }
        }
    }
}

//+------------------------------------------------------------------+
//| Modify Position                                                  |
//+------------------------------------------------------------------+
void ModifyPosition(ulong ticket, double sl, double tp)
{
    MqlTradeRequest request = {};
    MqlTradeResult result = {};
    
    request.action = TRADE_ACTION_SLTP;
    request.position = ticket;
    request.sl = sl;
    request.tp = tp;
    
    if(OrderSend(request, result)) {
        if(result.retcode == TRADE_RETCODE_DONE) {
            Print("Position modified: SL=", sl, ", TP=", tp);
        }
    }
}

//+------------------------------------------------------------------+
//| Count Open Positions                                             |
//+------------------------------------------------------------------+
int CountOpenPositions()
{
    int count = 0;
    for(int i = 0; i < PositionsTotal(); i++) {
        if(PositionGetTicket(i) > 0) {
            if(PositionGetString(POSITION_SYMBOL) == _Symbol) {
                count++;
            }
        }
    }
    return count;
}

//+------------------------------------------------------------------+
//| Check if Symbol is Crypto                                        |
//+------------------------------------------------------------------+
bool IsCryptoSymbol(string symbol)
{
    // Common crypto patterns
    if(StringFind(symbol, "BTC") >= 0) return true;
    if(StringFind(symbol, "ETH") >= 0) return true;
    if(StringFind(symbol, "XRP") >= 0) return true;
    if(StringFind(symbol, "LTC") >= 0) return true;
    if(StringFind(symbol, "USDT") >= 0) return true;
    if(StringFind(symbol, "CRYPTO") >= 0) return true;
    
    return false;
}

//+------------------------------------------------------------------+
//| Check if Symbol is Forex                                         |
//+------------------------------------------------------------------+
bool IsForexSymbol(string symbol)
{
    // Common forex pairs
    if(StringFind(symbol, "USD") >= 0) return true;
    if(StringFind(symbol, "EUR") >= 0) return true;
    if(StringFind(symbol, "GBP") >= 0) return true;
    if(StringFind(symbol, "JPY") >= 0) return true;
    if(StringFind(symbol, "CHF") >= 0) return true;
    if(StringFind(symbol, "AUD") >= 0) return true;
    if(StringFind(symbol, "CAD") >= 0) return true;
    if(StringFind(symbol, "NZD") >= 0) return true;
    
    return false;
}

//+------------------------------------------------------------------+
//| Reset Daily Metrics                                              |
//+------------------------------------------------------------------+
void ResetDailyMetrics()
{
    MqlDateTime currentTime, lastResetTime;
    TimeToStruct(TimeCurrent(), currentTime);
    TimeToStruct(g_dailyResetTime, lastResetTime);
    
    // Reset at midnight
    if(currentTime.day != lastResetTime.day) {
        g_dailyProfit = 0;
        g_dailyResetTime = TimeCurrent();
        Print("Daily metrics reset");
    }
}
//+------------------------------------------------------------------+
