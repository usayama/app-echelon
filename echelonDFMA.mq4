//+------------------------------------------------------------------+
//|                                                      Echelon.mq4 |
//|                                                          usayama |
//|                                                                  |
//+------------------------------------------------------------------+

#property copyright "usayama"

/* -----------------------------
グローバル変数の宣言
------------------------------ */

int tl[] = { 60, 240, 1440, 10080 };

/* -----------------------------
メイン関数：通貨と時間足を監視
------------------------------ */
int start() {

  // バーのチェック
  static int barsOld = 0;
  int barsNew = iBars(NULL, 1);
  int barsCheck = barsNew - barsOld;

  int i;
  if(barsCheck == 1) {
    for( i=0; i<ArraySize(tl); i++ ) { Echelon( "USDJPYmicro", tl[i] ); }
    for( i=0; i<ArraySize(tl); i++ ) { Echelon( "USDCHFmicro", tl[i] ); }
    for( i=0; i<ArraySize(tl); i++ ) { Echelon( "USDCADmicro", tl[i] ); }
    for( i=0; i<ArraySize(tl); i++ ) { Echelon( "USDSEKmicro", tl[i] ); }
    for( i=0; i<ArraySize(tl); i++ ) { Echelon( "USDNOKmicro", tl[i] ); }
    for( i=0; i<ArraySize(tl); i++ ) { Echelon( "USDCNHmicro", tl[i] ); }
    for( i=0; i<ArraySize(tl); i++ ) { Echelon( "USDMXNmicro", tl[i] ); }
    for( i=0; i<ArraySize(tl); i++ ) { Echelon( "USDZARmicro", tl[i] ); }
    for( i=0; i<ArraySize(tl); i++ ) { Echelon( "USDTRYmicro", tl[i] ); }
    for( i=0; i<ArraySize(tl); i++ ) { Echelon( "CADJPYmicro", tl[i] ); }
    for( i=0; i<ArraySize(tl); i++ ) { Echelon( "CADCHFmicro", tl[i] ); }
    for( i=0; i<ArraySize(tl); i++ ) { Echelon( "EURUSDmicro", tl[i] ); }
    for( i=0; i<ArraySize(tl); i++ ) { Echelon( "EURUSDmicro", tl[i] ); }
    for( i=0; i<ArraySize(tl); i++ ) { Echelon( "EURJPYmicro", tl[i] ); }
    for( i=0; i<ArraySize(tl); i++ ) { Echelon( "EURCADmicro", tl[i] ); }
    for( i=0; i<ArraySize(tl); i++ ) { Echelon( "EURGBPmicro", tl[i] ); }
    for( i=0; i<ArraySize(tl); i++ ) { Echelon( "EURCHFmicro", tl[i] ); }
    for( i=0; i<ArraySize(tl); i++ ) { Echelon( "EURAUDmicro", tl[i] ); }
    for( i=0; i<ArraySize(tl); i++ ) { Echelon( "EURNZDmicro", tl[i] ); }
    for( i=0; i<ArraySize(tl); i++ ) { Echelon( "EURNOKmicro", tl[i] ); }
    for( i=0; i<ArraySize(tl); i++ ) { Echelon( "EURSEKmicro", tl[i] ); }
    for( i=0; i<ArraySize(tl); i++ ) { Echelon( "EURZARmicro", tl[i] ); }
    for( i=0; i<ArraySize(tl); i++ ) { Echelon( "EURTRYmicro", tl[i] ); }
    for( i=0; i<ArraySize(tl); i++ ) { Echelon( "CHFJPYmicro", tl[i] ); }
    for( i=0; i<ArraySize(tl); i++ ) { Echelon( "GBPJPYmicro", tl[i] ); }
    for( i=0; i<ArraySize(tl); i++ ) { Echelon( "GBPUSDmicro", tl[i] ); }
    for( i=0; i<ArraySize(tl); i++ ) { Echelon( "GBPCADmicro", tl[i] ); }
    for( i=0; i<ArraySize(tl); i++ ) { Echelon( "GBPCHFmicro", tl[i] ); }
    for( i=0; i<ArraySize(tl); i++ ) { Echelon( "GBPAUDmicro", tl[i] ); }
    for( i=0; i<ArraySize(tl); i++ ) { Echelon( "GBPNZDmicro", tl[i] ); }
    for( i=0; i<ArraySize(tl); i++ ) { Echelon( "AUDJPYmicro", tl[i] ); }
    for( i=0; i<ArraySize(tl); i++ ) { Echelon( "AUDUSDmicro", tl[i] ); }
    for( i=0; i<ArraySize(tl); i++ ) { Echelon( "AUDCADmicro", tl[i] ); }
    for( i=0; i<ArraySize(tl); i++ ) { Echelon( "AUDCHFmicro", tl[i] ); }
    for( i=0; i<ArraySize(tl); i++ ) { Echelon( "AUDNZDmicro", tl[i] ); }
  }
  barsOld = barsNew;
  return(0);
}

/* ---------------------------------------
Echelon：取引期会を通知
---------------------------------------- */

bool Echelon(string s, int t) {

  double range13, range89;

  // 時間足による乖離率の振り分け
  switch(t) {
    case 60: //60分
      range13 = 0.3;
      range89 = 0.9;
      break;
    case 240: //4時間
      range13 = 0.6;
      range89 = 1.8;
      break;
    case 1440: //1日
      range13 = 2.0;
      range89 = 6.0;
      break;
    case 10080: //1週間
      range13 = 5.0;
      range89 = 15.0;
      break;
  }

  // 現在の値段
  double price = iClose(s, t, 0);

  // 移動平均線
  double ma13 = iMA(s, t, 13, 0, MODE_SMA, PRICE_CLOSE, 0);
  double ma89 = iMA(s, t, 89, 0, MODE_SMA, PRICE_CLOSE, 0);

  // 移動平均線乖離率
  double dfma13 = ((price - ma13) / ma13) * 100;
  double dfma89 = ((price - ma89) / ma89) * 100;

  // 乖離率の％表示
  double retio13 = MathRound((dfma13 / range13) *100);
  double retio89 = MathRound((dfma89 / range89) *100);

  // 移動平均線乖離判定
  bool over  = dfma13 > range13 && dfma89 > range89;
  bool under = dfma13 < -range13 && dfma89 < -range89;

  // 乖離率送信
  string msgOver  = StringConcatenate(s, ": ", t, "｜売｜", "近: ", retio13, "｜遠: ", retio89);
  string msgUnder = StringConcatenate(s, ": ", t, "｜買｜", "近: ", retio13, "｜遠: ", retio89);

  // 移動平均線の乖離を通知
  if(over) {
    SendNotification(msgOver);
  }
  else if(under) {
    SendNotification(msgUnder);
  }

  return(0);
}
