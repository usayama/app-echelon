//+------------------------------------------------------------------+
//|                                                         test.mq5 |
//|                        Copyright 2017, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2017, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"

/* -----------------------------
グローバル変数の宣言
------------------------------ */

// スコープ倍率
double scopeGain;
// 短期移動平均線乖離率
double scopeGapLightPosi;
double scopeGapLightNega;
// 長期移動平均線乖離率
double scopeGapHeavyPosi;
double scopeGapHeavyNega;

ENUM_TIMEFRAMES tl[] = { PERIOD_H1, PERIOD_H4, PERIOD_D1, PERIOD_W1 };

/* ---------------------------------------
Difine MQL4 Function
---------------------------------------- */

double Low[];
double High[];
double Open[];
double Close[];

double iLow(string symbol,ENUM_TIMEFRAMES timeframe,int index) {
  double low=0;
  ArraySetAsSeries(Low,true);
  int copied=CopyLow(symbol,timeframe,0,Bars(symbol,timeframe),Low);
  if(copied>0 && index<copied) low=Low[index];
  return(low);
}

double iHigh(string symbol,ENUM_TIMEFRAMES timeframe,int index) {
  double high=0;
  ArraySetAsSeries(High,true);
  int copied=CopyLow(symbol,timeframe,0,Bars(symbol,timeframe),High);
  if(copied>0 && index<copied) high=High[index];
  return(high);
}

double iOpen(string symbol,ENUM_TIMEFRAMES timeframe,int index) {
  double open=0;
  ArraySetAsSeries(Open,true);
  int copied=CopyLow(symbol,timeframe,0,Bars(symbol,timeframe),Open);
  if(copied>0 && index<copied) open=Open[index];
  return(open);
}

double iClose(string symbol,ENUM_TIMEFRAMES timeframe,int index) {
  double close=0;
  ArraySetAsSeries(Close,true);
  int copied=CopyLow(symbol,timeframe,0,Bars(symbol,timeframe),Close);
  if(copied>0 && index<copied) close=Close[index];
  return(close);
}

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---

//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---

  }

/* -----------------------------
メイン関数：通貨と時間足を監視
------------------------------ */
int OnTick() {

  /*【 バーのチェック 】*/
  static int barsOld = 0;
  int barsNew = Bars( NULL, 5 );
  int barsCheck = barsNew - barsOld;

  int i;
  if( barsCheck == 1 ) {
    for( i=0; i<ArraySize(tl); i++ ) { Echelon( "USDJPYmicro", tl[i] ); }
    for( i=0; i<ArraySize(tl); i++ ) { Echelon( "USDCADmicro", tl[i] ); }
    for( i=0; i<ArraySize(tl); i++ ) { Echelon( "USDCHFmicro", tl[i] ); }
    for( i=0; i<ArraySize(tl); i++ ) { Echelon( "USDHKDmicro", tl[i] ); }
  }
  barsOld = barsNew;
  return(0);
}

//+------------------------------------------------------------------+

/* ---------------------------------------
Echelon：取引期会を通知
---------------------------------------- */

bool Echelon( string s, ENUM_TIMEFRAMES t ) {

  switch(t) {
    case PERIOD_H1: //60分
      scopeGain = 60 * 6;
      scopeGapLightPosi = 0.2;
      scopeGapHeavyPosi = 1;
      scopeGapLightNega = -0.2;
      scopeGapHeavyNega = -1;
      break;
    case PERIOD_H4: //4時間
      scopeGain = 240 * 3;
      scopeGapLightPosi = 0.4;
      scopeGapHeavyPosi = 1.2;
      scopeGapLightNega = -0.4;
      scopeGapHeavyNega = -1.2;
      break;
    case PERIOD_D1: //1日
      scopeGain = 1440 * 2;
      scopeGapLightPosi = 0.6;
      scopeGapHeavyPosi = 1.8;
      scopeGapLightNega = -0.6;
      scopeGapHeavyNega = -1.8;
      break;
    case PERIOD_W1: //1週間
      scopeGain = 10080 * 1;
      scopeGapLightPosi = 3;
      scopeGapHeavyPosi = 14;
      scopeGapLightNega = -3;
      scopeGapHeavyNega = -14;
      break;
  }

  /*【 変数の宣言 】*/
  // 現在の値段
  double newClose = iClose( s, t, 0 ); // 現在値
  double newOpen = iOpen( s, t, 0 );   // 始値
  double newHigh = iHigh( s, t, 0 );   // 高値
  double newLow = iLow( s, t, 0 );     // 安値

  double oldClose = iClose( s, t, 1 ); // 一本前の終値
  double oldOpen = iOpen( s, t, 1 );   // 一本前の始値
  double oldHigh = iHigh( s, t, 1 );   // 一本前の高値
  double oldLow = iLow( s, t, 1 );     // 一本前の安値

  // 移動平均線
  double maNewA = iMA( s, t, 7, 0, MODE_SMA, PRICE_CLOSE );
  double maNewB = iMA( s, t, 13, 0, MODE_SMA, PRICE_CLOSE );
  double maNewC = iMA( s, t, 24, 0, MODE_SMA, PRICE_CLOSE );
  double maNewD = iMA( s, t, 44, 0, MODE_SMA, PRICE_CLOSE );
  double maNewE = iMA( s, t, 81, 0, MODE_SMA, PRICE_CLOSE );

  // 移動平均線乖離率
  double maGapA = ( newClose - maNewA ) / maNewA * 100;
  double maGapE = ( newClose - maNewE ) / maNewE * 100;

  // 乖離倍率
  double kinkairiDown = MathRound( maGapA / scopeGapLightNega * 100 );
  double enkairiDown = MathRound( maGapE / scopeGapHeavyNega * 100 );
  double kinkairiUp = MathRound( maGapA / scopeGapLightPosi * 100 );
  double enkairiUp = MathRound( maGapE / scopeGapHeavyPosi * 100 );

  /*【 移動平均線乖離判定 】*/
  bool SignalGapDownA = maGapA < scopeGapLightNega && maGapE < scopeGapHeavyNega && iRSI( s, t, 14, 0 ) < 25;
  bool SignalGapDownB = maGapA < scopeGapLightNega * 1.5 && maGapE < scopeGapHeavyNega && iRSI( s, t, 14, 0 ) < 30;
  bool SignalGapDownC = iRSI( s, t, 14, 0 ) < 16;
  bool SignalGapUpA = maGapA > scopeGapLightPosi && maGapE > scopeGapHeavyPosi && iRSI( s, t, 14, 0 ) > 75;
  bool SignalGapUpB = maGapA > scopeGapLightPosi * 1.5 && maGapE > scopeGapHeavyPosi && iRSI( s, t, 14, 0 ) > 70;
  bool SignalGapUpC = iRSI( s, t, 14, 0 ) > 84;

  /* ------------------------------
  乖離率判定
  ------------------------------ */

  // 移動平均線の下方乖離を通知
  if( SignalGapDownA || SignalGapDownB || SignalGapDownC ) {
    string maGapStrLower = StringConcatenate( s, "：", t, "分の乖離率で買い", "｜", "RSI：", MathRound( iRSI( s, t, 13, 0 ) ), "｜", "近乖離：", kinkairiDown, "%", "｜", "遠乖離：", enkairiDown, "%" );
    SendNotification( maGapStrLower );
  }
  // 移動平均線の上方乖離を通知
  else if( SignalGapUpA || SignalGapUpB || SignalGapUpC ) {
    string maGapStrUpper = StringConcatenate( s, "：", t, "分の乖離率で売り","｜", "RSI：", MathRound( iRSI( s, t, 13, 0 ) ), "｜", "近乖離：", kinkairiUp, "%", "｜", "遠乖離：", enkairiUp, "%" );
    SendNotification( maGapStrUpper );
  }
  return(0);
}
