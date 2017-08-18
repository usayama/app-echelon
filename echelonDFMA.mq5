//+------------------------------------------------------------------+
//|                                                      Echelon.mq4 |
//|                                                          usayama |
//|                                                                  |
//+------------------------------------------------------------------+

#property copyright "usayama"

/* -----------------------------
グローバル変数の宣言
------------------------------ */

ENUM_TIMEFRAMES tl[] = { PERIOD_H1, PERIOD_H4, PERIOD_D1 };

/* -----------------------------
関数iCloseを使えるようにする
------------------------------ */

double Close[];

double iClose(string symbol,ENUM_TIMEFRAMES timeframe,int index) {
  double close=0;
  ArraySetAsSeries(Close,true);
  int copied=CopyLow(symbol,timeframe,0,Bars(symbol,timeframe),Close);
  if(copied>0 && index<copied) close=Close[index];
  return(close);
}

/* ---------------------------------------
// 初期化関数
---------------------------------------- */

int OnInit() {
  return(INIT_SUCCEEDED);
}

/* -----------------------------
メイン関数：通貨と時間足を監視
------------------------------ */
void OnTick() {

  int i;
  for( i=0; i<ArraySize(tl); i++ ) { Echelon( "USDJPYmicro", tl[i] ); }
  for( i=0; i<ArraySize(tl); i++ ) { Echelon( "USDCHFmicro", tl[i] ); }
  for( i=0; i<ArraySize(tl); i++ ) { Echelon( "USDCADmicro", tl[i] ); }
  for( i=0; i<ArraySize(tl); i++ ) { Echelon( "USDSEKmicro", tl[i] ); }
  for( i=0; i<ArraySize(tl); i++ ) { Echelon( "USDNOKmicro", tl[i] ); }
  // for( i=0; i<ArraySize(tl); i++ ) { Echelon( "USDCNHmicro", tl[i] ); }
  // for( i=0; i<ArraySize(tl); i++ ) { Echelon( "USDMXNmicro", tl[i] ); }
  // for( i=0; i<ArraySize(tl); i++ ) { Echelon( "USDZARmicro", tl[i] ); }
  for( i=0; i<ArraySize(tl); i++ ) { Echelon( "CADJPYmicro", tl[i] ); }
  // for( i=0; i<ArraySize(tl); i++ ) { Echelon( "CADCHFmicro", tl[i] ); }
  for( i=0; i<ArraySize(tl); i++ ) { Echelon( "EURUSDmicro", tl[i] ); }
  for( i=0; i<ArraySize(tl); i++ ) { Echelon( "EURJPYmicro", tl[i] ); }
  // for( i=0; i<ArraySize(tl); i++ ) { Echelon( "EURCADmicro", tl[i] ); }
  for( i=0; i<ArraySize(tl); i++ ) { Echelon( "EURGBPmicro", tl[i] ); }
  for( i=0; i<ArraySize(tl); i++ ) { Echelon( "EURCHFmicro", tl[i] ); }
  for( i=0; i<ArraySize(tl); i++ ) { Echelon( "EURAUDmicro", tl[i] ); }
  // for( i=0; i<ArraySize(tl); i++ ) { Echelon( "EURNZDmicro", tl[i] ); }
  for( i=0; i<ArraySize(tl); i++ ) { Echelon( "EURNOKmicro", tl[i] ); }
  for( i=0; i<ArraySize(tl); i++ ) { Echelon( "EURSEKmicro", tl[i] ); }
  for( i=0; i<ArraySize(tl); i++ ) { Echelon( "EURZARmicro", tl[i] ); }
  for( i=0; i<ArraySize(tl); i++ ) { Echelon( "EURTRYmicro", tl[i] ); }
  for( i=0; i<ArraySize(tl); i++ ) { Echelon( "CHFJPYmicro", tl[i] ); }
  for( i=0; i<ArraySize(tl); i++ ) { Echelon( "GBPJPYmicro", tl[i] ); }
  for( i=0; i<ArraySize(tl); i++ ) { Echelon( "GBPUSDmicro", tl[i] ); }
  for( i=0; i<ArraySize(tl); i++ ) { Echelon( "GBPCADmicro", tl[i] ); }
  // for( i=0; i<ArraySize(tl); i++ ) { Echelon( "GBPCHFmicro", tl[i] ); }
  for( i=0; i<ArraySize(tl); i++ ) { Echelon( "GBPAUDmicro", tl[i] ); }
  for( i=0; i<ArraySize(tl); i++ ) { Echelon( "GBPNZDmicro", tl[i] ); }
  for( i=0; i<ArraySize(tl); i++ ) { Echelon( "AUDJPYmicro", tl[i] ); }
  for( i=0; i<ArraySize(tl); i++ ) { Echelon( "AUDUSDmicro", tl[i] ); }
  for( i=0; i<ArraySize(tl); i++ ) { Echelon( "AUDCADmicro", tl[i] ); }
  for( i=0; i<ArraySize(tl); i++ ) { Echelon( "AUDCHFmicro", tl[i] ); }
  // for( i=0; i<ArraySize(tl); i++ ) { Echelon( "AUDNZDmicro", tl[i] ); }
  for( i=0; i<ArraySize(tl); i++ ) { Echelon( "NZDJPYmicro", tl[i] ); }
  for( i=0; i<ArraySize(tl); i++ ) { Echelon( "NZDUSDmicro", tl[i] ); }
  for( i=0; i<ArraySize(tl); i++ ) { Echelon( "NZDCADmicro", tl[i] ); }
  // for( i=0; i<ArraySize(tl); i++ ) { Echelon( "NZDCHFmicro", tl[i] ); }
  for( i=0; i<ArraySize(tl); i++ ) { Echelon( "GOLDmicro", tl[i] ); }
  // for( i=0; i<ArraySize(tl); i++ ) { Echelon( "SILVERmicro", tl[i] ); }

  Sleep(60000);

}

/* ---------------------------------------
Echelon：取引期会を通知
---------------------------------------- */

bool Echelon(string s, ENUM_TIMEFRAMES t) {

  // 現在の値段
  double price = iClose(s, t, 0);

    string time;

    switch(t) {
      case 16385:
        time = "1H";
        break;
      case 16386:
        time = "2H";
        break;
      case 16387:
        time = "3H";
        break;
      case 16388:
        time = "4H";
        break;
      case 16390:
        time = "6H";
        break;
      case 16392:
        time = "8H";
        break;
      case 16396:
        time = "12H";
        break;
      case 16408:
        time = "1H";
        break;
      case 32769:
        time = "1H";
        break;
    }

  // 変数定義
  int hMA13 = 0;
  int hMA89 = 0;
  double bufMA13[];
  double bufMA89[];
  double range13, range89;

  // iMAハンドルの取得とコピー
  hMA13 = iMA(s, t, 13, 0, MODE_SMA, PRICE_CLOSE);
  hMA89 = iMA(s, t, 89, 0, MODE_SMA, PRICE_CLOSE);
  CopyBuffer(hMA13, 0, 0, 1, bufMA13);
  CopyBuffer(hMA89, 0, 0, 1, bufMA89);

  // 移動平均線
  double ma13 = NormalizeDouble(bufMA13[0], 8);
  double ma89 = NormalizeDouble(bufMA89[0], 8);

  // 時間足による乖離率の振り分け
  switch(t) {
    case PERIOD_H1: //60分
      range13 = 0.15;
      range89 = 0.45;
      // range13 = 0.3;
      // range89 = 0.9;
      break;
    case PERIOD_H4: //4時間
      range13 = 0.3;
      range89 = 0.9;
      // range13 = 0.6;
      // range89 = 1.8;
      break;
    case PERIOD_D1: //1日
      range13 = 1.0;
      range89 = 3.0;
      // range13 = 2.0;
      // range89 = 6.0;
      break;
    case PERIOD_W1: //1週間
      range13 = 2.5;
      range89 = 7.5;
      // range13 = 5.0;
      // range89 = 15.0;
      break;
  }

  // 移動平均線乖離率
  double dfma13 = NormalizeDouble(((price - ma13) / ma13) * 100, 8);
  double dfma89 = NormalizeDouble(((price - ma89) / ma89) * 100, 8);

  // 乖離率の％表示
  string retio13 = DoubleToString(MathRound((dfma13 / range13) *100), 0);
  string retio89 = DoubleToString(MathRound((dfma89 / range89) *100), 0);

  // 移動平均線乖離判定
  bool over  = dfma13 > range13 && dfma89 > range89;
  bool under = dfma13 < -range13 && dfma89 < -range89;

  // 乖離率送信
  string msgOver  = s + ": " + time + "｜売｜" + "近: " + retio13 + "｜遠: " + retio89;
  string msgUnder = s + ": " + time + "｜買｜" + "近: " + retio13 + "｜遠: " + retio89;

  // 移動平均線の乖離を通知
  if(over) {
    SendNotification(msgOver);
  }
  else if(under) {
    SendNotification(msgUnder);
  }

  return(0);
}

/* ---------------------------------------
// 終了処理関数
---------------------------------------- */

void OnDeinit(const int reason) {

}
