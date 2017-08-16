//+------------------------------------------------------------------+
//|                                                         test.mq5 |
//|                        Copyright 2017, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+

#property version   "1.00"

/* -----------------------------
グローバル変数の宣言
------------------------------ */

ENUM_TIMEFRAMES tl[] = { PERIOD_H1, PERIOD_H4, PERIOD_D1, PERIOD_W1 };

// プリプロセッサ命令
#property indicator_separate_window
#property indicator_buffers 1
#property indicator_plots   1
#property indicator_type1   DRAW_LINE
#property indicator_color1  clrRed

// 指標バッファ用の配列の宣言
double Buf[];

// 外部パラメータ
input int RSIPeriod = 13;  // RSIの期間

// テクニカル指標ハンドル
int hRSI;

//+------------------------------------------------------------------+
// 初期化関数
//+------------------------------------------------------------------+

int OnInit() {
  // 指標バッファの割り当て
  SetIndexBuffer(0, Buf, INDICATOR_DATA);
  ArraySetAsSeries(Buf, true);

  // テクニカル指標の初期化
  hRSI = iRSI(NULL, 0, RSIPeriod, PRICE_CLOSE);
  return(INIT_SUCCEEDED);
}

//+------------------------------------------------------------------+
// 指標計算関数
//+------------------------------------------------------------------+

int OnCalculate(
  const int rates_total,
  const int prev_calculated,
  const datetime& Time[],
  const double& Open[],
  const double& High[],
  const double& Low[],
  const double& Close[],
  const long& Tick_volume[],
  const long& Volume[],
  const int& Spread[])
{
  // カスタム指標の範囲
  int limit = rates_total - prev_calculated;
  if(limit == 0) limit = 1;

  // バッファのコピー
  CopyBuffer(hRSI, 0, 0, limit, Buf);
  return(rates_total);
}

/* -----------------------------
メイン関数：通貨と時間足を監視
------------------------------ */

void OnTick() {

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
}

/* ---------------------------------------
Echelon：取引期会を通知
---------------------------------------- */

bool Echelon(string s, ENUM_TIMEFRAMES t) {

  // RSI判定
  int RSI = (int)MathRound(Buf[0]);
  string msgRSI = (string)StringConcatenate(s, "：", t, "分のRSI：", RSI);

  if(RSI >= 60) {
    SendNotification(msgRSI);
  } else if(RSI <= 40) {
    SendNotification(msgRSI);
  }

  return(0);
}

//+------------------------------------------------------------------+
// 終了処理関数
//+------------------------------------------------------------------+

void OnDeinit(const int reason) {
  // テクニカル指標の解放
  IndicatorRelease(hRSI);
}
