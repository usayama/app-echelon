//+------------------------------------------------------------------+
//|                                                      Echelon.mq4 |
//|                                                          usayama |
//|                                                                  |
//+------------------------------------------------------------------+

#property copyright "usayama"

/* -----------------------------
グローバル変数の宣言
------------------------------ */

ENUM_TIMEFRAMES tl[] = { PERIOD_H1, PERIOD_H2, PERIOD_H3, PERIOD_H4, PERIOD_H6, PERIOD_H8, PERIOD_H12, PERIOD_D1, PERIOD_W1 };

// DFMA変数定義
int hMA13 = 0;
int hMA89 = 0;
double bufMA13[];
double bufMA89[];
double range13, range89;
double ma13 = 0;
double ma89 = 0;
double dfma13;
double dfma89;
string retio13;
string retio89;
bool overDFMA;
bool underDFMA;
string msgOverDFMA;
string msgUnderDFMA;

// RSI変数定義
int hRSI = 0;
double bufRSI[];
double rsi = 0;
string msgRSI;

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
  for( i=0; i<ArraySize(tl); i++ ) { Echelon( "NZDJPYmicro", tl[i] ); }
  for( i=0; i<ArraySize(tl); i++ ) { Echelon( "NZDUSDmicro", tl[i] ); }
  for( i=0; i<ArraySize(tl); i++ ) { Echelon( "NZDCADmicro", tl[i] ); }
  for( i=0; i<ArraySize(tl); i++ ) { Echelon( "NZDCHFmicro", tl[i] ); }
  for( i=0; i<ArraySize(tl); i++ ) { Echelon( "GOLDmicro", tl[i] ); }
  for( i=0; i<ArraySize(tl); i++ ) { Echelon( "SILVERmicro", tl[i] ); }
  for( i=0; i<ArraySize(tl); i++ ) { Echelon( "JP225Cash", tl[i] ); }
  for( i=0; i<ArraySize(tl); i++ ) { Echelon( "US30Cash", tl[i] ); }
  for( i=0; i<ArraySize(tl); i++ ) { Echelon( "US100Cash", tl[i] ); }
  for( i=0; i<ArraySize(tl); i++ ) { Echelon( "US500Cash", tl[i] ); }
  for( i=0; i<ArraySize(tl); i++ ) { Echelon( "EU50Cash", tl[i] ); }
  for( i=0; i<ArraySize(tl); i++ ) { Echelon( "AUS200Cash", tl[i] ); }
  for( i=0; i<ArraySize(tl); i++ ) { Echelon( "UK100Cash", tl[i] ); }
  for( i=0; i<ArraySize(tl); i++ ) { Echelon( "GER30Cash", tl[i] ); }
  for( i=0; i<ArraySize(tl); i++ ) { Echelon( "FRA40Cash", tl[i] ); }
  for( i=0; i<ArraySize(tl); i++ ) { Echelon( "HK50Cash", tl[i] ); }
  for( i=0; i<ArraySize(tl); i++ ) { Echelon( "SWI20Cash", tl[i] ); }
  for( i=0; i<ArraySize(tl); i++ ) { Echelon( "SPAIN35Cash", tl[i] ); }
  for( i=0; i<ArraySize(tl); i++ ) { Echelon( "IT40Cash", tl[i] ); }
  for( i=0; i<ArraySize(tl); i++ ) { Echelon( "CHI50Cash", tl[i] ); }
  Sleep(60000);

}

/* ---------------------------------------
Echelon：取引期会を通知
---------------------------------------- */

bool Echelon(string s, ENUM_TIMEFRAMES t) {

  // 現在の値段
  double price = iClose(s, t, 0);

  // 時間足を文字列に変換
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
      time = "1D";
      break;
    case 32769:
      time = "1W";
      break;
  }

  // iRSIハンドルの取得とコピー
  hRSI= iRSI(s, t, 13, PRICE_CLOSE);
  CopyBuffer(hRSI, 0, 0, 1, bufRSI);

  // iMAハンドルの取得とコピー
  hMA13 = iMA(s, t, 13, 0, MODE_SMA, PRICE_CLOSE);
  hMA89 = iMA(s, t, 89, 0, MODE_SMA, PRICE_CLOSE);
  CopyBuffer(hMA13, 0, 0, 1, bufMA13);
  CopyBuffer(hMA89, 0, 0, 1, bufMA89);

  // 移動平均線
  ma13 = NormalizeDouble(bufMA13[0], 16);
  ma89 = NormalizeDouble(bufMA89[0], 16);

  // RSI
  rsi = NormalizeDouble(bufRSI[0], 1);

  if(ma13 > 0) {
    if(ma89 > 0) {

      // 時間足による乖離率の振り分け
      switch(t) {
        case PERIOD_H1: //60分
          // range13 = 0.15;
          // range89 = 0.45;
          range13 = 0.3;
          range89 = 0.9;
          break;
        case PERIOD_H2: //60分
          // range13 = 0.15;
          // range89 = 0.45;
          range13 = 0.4;
          range89 = 1.2;
          break;
        case PERIOD_H3: //60分
          // range13 = 0.15;
          // range89 = 0.45;
          range13 = 0.5;
          range89 = 1.5;
          break;
        case PERIOD_H4: //4時間
          // range13 = 0.3;
          // range89 = 0.9;
          range13 = 0.6;
          range89 = 1.8;
          break;
        case PERIOD_H6: //4時間
          // range13 = 0.3;
          // range89 = 0.9;
          range13 = 0.7;
          range89 = 2.1;
          break;
        case PERIOD_H8: //4時間
          // range13 = 0.3;
          // range89 = 0.9;
          range13 = 0.8;
          range89 = 2.4;
          break;
        case PERIOD_H12: //4時間
          // range13 = 0.3;
          // range89 = 0.9;
          range13 = 1.0;
          range89 = 3.0;
          break;
        case PERIOD_D1: //1日
          // range13 = 1.0;
          // range89 = 3.0;
          range13 = 2.0;
          range89 = 6.0;
          break;
        case PERIOD_W1: //1週間
          // range13 = 2.5;
          // range89 = 7.5;
          range13 = 5.0;
          range89 = 15.0;
          break;
        default:
          range13 = 999;
          range89 = 999;
          break;
      }

      // 移動平均線乖離率
      dfma13 = NormalizeDouble(((price - ma13) / ma13) * 100, 16);
      dfma89 = NormalizeDouble(((price - ma89) / ma89) * 100, 16);

      // 乖離率の％表示
      retio13 = DoubleToString(MathRound((dfma13 / range13) *100), 0);
      retio89 = DoubleToString(MathRound((dfma89 / range89) *100), 0);

      // 移動平均線乖離判定
      overDFMA  = dfma13 > range13 && dfma89 > range89;
      underDFMA = dfma13 < -range13 && dfma89 < -range89;

      // 乖離率送信
      msgOverDFMA  = s + ": " + time + "｜売｜" + "近: " + retio13 + "｜遠: " + retio89;
      msgUnderDFMA = s + ": " + time + "｜買｜" + "近: " + retio13 + "｜遠: " + retio89;

      // RSI判定
      msgRSI = s + " : " + time + "のRSI : " + DoubleToString(rsi, 1);

      // 移動平均線の乖離を通知
      if(overDFMA) {
        SendNotification(msgOverDFMA);
      }
      else if(underDFMA) {
        SendNotification(msgUnderDFMA);
      }

      // RSIの観測を通知
      if(rsi <= 20) {
        if(rsi > 0) {
          SendNotification(msgRSI);
        }
      } else if(rsi >= 80) {
        SendNotification(msgRSI);
      }
    }
  }

  return(0);
}

/* ---------------------------------------
// 終了処理関数
---------------------------------------- */

void OnDeinit(const int reason) {

}
