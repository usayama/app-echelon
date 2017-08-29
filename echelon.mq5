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
string strRSI;
string msgRSI;

// 共通変数定義
string name;
ENUM_TIMEFRAMES time;
string period;
string sbl;
int i=0;

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

double price;

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
  for( i=0; i<ArraySize(tl); i++ ) { Echelon( "IT40Cash", tl[i] ); }
  for( i=0; i<ArraySize(tl); i++ ) { Echelon( "CHI50Cash", tl[i] ); }
  Sleep(60000);
}

/* ---------------------------------------
Echelon：取引期会を通知
---------------------------------------- */

bool Echelon(string s, ENUM_TIMEFRAMES t) {

  name = s;
  time = t;
  sbl = name;

  // microを削除
  StringReplace(sbl, "micro", "");
  StringReplace(sbl, "Cash", "");

  // 現在の値段
  price = iClose(name, time, 0);

  // 時間足を文字列に変換
  switch(time) {
    case 16385:
      period = "1H";
      break;
    case 16386:
      period = "2H";
      break;
    case 16387:
      period = "3H";
      break;
    case 16388:
      period = "4H";
      break;
    case 16390:
      period = "6H";
      break;
    case 16392:
      period = "8H";
      break;
    case 16396:
      period = "12H";
      break;
    case 16408:
      period = "1D";
      break;
    case 32769:
      period = "1W";
      break;
  }

  /* ---------------
  RSI
  --------------- */

  // iRSIハンドルの取得
  hRSI = iRSI(name, time, 13, PRICE_CLOSE);
  if(hRSI != -1) {
    // ハンドルをコピー
    CopyBuffer(hRSI, 0, 0, 1, bufRSI);
    // RSI
    rsi = NormalizeDouble(bufRSI[0], 1);
    // RSIを文字列化
    strRSI = DoubleToString(rsi, 1);
    // RSIメッセージ
    msgRSI = sbl + ": " + period + "｜RSI : " + strRSI;
    // RSI判定
    if(rsi <= 20) {
      SendNotification(msgRSI);
    } else if(rsi >= 80) {
      SendNotification(msgRSI);
    }
  }

  /* ---------------
  DFMA
  --------------- */

  // iMAハンドルの取得
  hMA13 = iMA(name, time, 13, 0, MODE_SMA, PRICE_CLOSE);
  hMA89 = iMA(name, time, 89, 0, MODE_SMA, PRICE_CLOSE);

  // ハンドル取得にエラーがでなかったとき
  if(hMA13 != -1) {
    if(hMA89 != -1) {

      // ハンドルをコピー
      CopyBuffer(hMA13, 0, 0, 1, bufMA13);
      CopyBuffer(hMA89, 0, 0, 1, bufMA89);

      // 移動平均線
      ma13 = NormalizeDouble(bufMA13[0], 4);
      ma89 = NormalizeDouble(bufMA89[0], 4);

      // 時間足による乖離率の振り分け
      switch(time) {
        case PERIOD_H1:
          // range13 = 0.15;
          // range89 = 0.45;
          range13 = 0.3;
          range89 = 1.2;
          break;
        case PERIOD_H2:
          // range13 = 0.15;
          // range89 = 0.45;
          range13 = 0.35;
          range89 = 1.4;
          break;
        case PERIOD_H3:
          // range13 = 0.15;
          // range89 = 0.45;
          range13 = 0.4;
          range89 = 1.6;
          break;
        case PERIOD_H4:
          // range13 = 0.3;
          // range89 = 0.9;
          range13 = 0.5;
          range89 = 2.0;
          break;
        case PERIOD_H6:
          // range13 = 0.3;
          // range89 = 0.9;
          range13 = 0.6;
          range89 = 2.4;
          break;
        case PERIOD_H8:
          // range13 = 0.3;
          // range89 = 0.9;
          range13 = 0.7;
          range89 = 2.8;
          break;
        case PERIOD_H12:
          // range13 = 0.3;
          // range89 = 0.9;
          range13 = 0.8;
          range89 = 3.2;
          break;
        case PERIOD_D1:
          // range13 = 1.0;
          // range89 = 3.0;
          range13 = 1.25;
          range89 = 5.0;
          break;
        case PERIOD_W1:
          // range13 = 2.5;
          // range89 = 7.5;
          range13 = 2.5;
          range89 = 10;
          break;
        default:
          range13 = 999;
          range89 = 999;
          break;
      }

      // 移動平均線乖離率
      dfma13 = NormalizeDouble(((price - ma13) / ma13) * 100, 2);
      dfma89 = NormalizeDouble(((price - ma89) / ma89) * 100, 2);

      // 乖離率の％表示
      retio13 = DoubleToString(MathRound((dfma13 / range13) *100), 0);
      retio89 = DoubleToString(MathRound((dfma89 / range89) *100), 0);

      // 乖離率送信
      msgOverDFMA  = sbl + ": " + period + "｜S｜近: " + retio13 + "｜遠: " + retio89 + "｜R: " + strRSI;
      msgUnderDFMA = sbl + ": " + period + "｜L｜近: " + retio13 + "｜遠: " + retio89 + "｜R: " + strRSI;

      // 移動平均線の乖離を通知
      if(dfma13 > range13) {
        if(dfma89 > range89) {
          SendNotification(msgOverDFMA);
        }
      }
      else if(dfma13 < -range13) {
        if(dfma89 < -range89) {
          SendNotification(msgUnderDFMA);
        }
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
