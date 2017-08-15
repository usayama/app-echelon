//+------------------------------------------------------------------+
//|                                                      Echelon.mq4 |
//|                                                          usayama |
//|                                                                  |
//+------------------------------------------------------------------+
#property copyright "usayama"
#property version   "9.4"

/* -----------------------------
グローバル変数の宣言
------------------------------ */
extern int flexTime = 5;
extern double flexGain = 1;
extern bool maGapAlert = false;
extern bool adxAlert = false;
extern bool cloudCrossAlert = false;
extern bool superLineAlert = false;
extern bool typeAlert = false;
extern bool trendAlert = false;

// スコープ倍率
double scopeGain;
// 短期移動平均線乖離率
double scopeGapLightPosi;
double scopeGapLightNega;
// 長期移動平均線乖離率
double scopeGapHeavyPosi;
double scopeGapHeavyNega;
// ADX倍率
int scopeAdx;

int tl[] = { 60, 240, 1440, 10080 };

/* -----------------------------
メイン関数：通貨と時間足を監視
------------------------------ */
int start() {

    /*【 バーのチェック 】*/
    static int barsOld = 0;
    int barsNew = iBars( NULL, flexTime );
    int barsCheck = barsNew - barsOld;

    int i;
    if( barsCheck == 1 ) {
        for( i=0; i<ArraySize(tl); i++ ) { Echelon( "USDJPY", tl[i] ); }
        for( i=0; i<ArraySize(tl); i++ ) { Echelon( "USDCAD", tl[i] ); }
        for( i=0; i<ArraySize(tl); i++ ) { Echelon( "USDCHF", tl[i] ); }
        for( i=0; i<ArraySize(tl); i++ ) { Echelon( "USDHKD", tl[i] ); }
        for( i=0; i<ArraySize(tl); i++ ) { Echelon( "USDSEK", tl[i] ); }
        for( i=0; i<ArraySize(tl); i++ ) { Echelon( "USDTRY", tl[i] ); }
        for( i=0; i<ArraySize(tl); i++ ) { Echelon( "USDMXN", tl[i] ); }
        for( i=0; i<ArraySize(tl); i++ ) { Echelon( "USDZAR", tl[i] ); }
        for( i=0; i<ArraySize(tl); i++ ) { Echelon( "EURUSD", tl[i] ); }
        for( i=0; i<ArraySize(tl); i++ ) { Echelon( "EURJPY", tl[i] ); }
        for( i=0; i<ArraySize(tl); i++ ) { Echelon( "EURGBP", tl[i] ); }
        for( i=0; i<ArraySize(tl); i++ ) { Echelon( "EURCHF", tl[i] ); }
        for( i=0; i<ArraySize(tl); i++ ) { Echelon( "EURAUD", tl[i] ); }
        for( i=0; i<ArraySize(tl); i++ ) { Echelon( "EURNZD", tl[i] ); }
        for( i=0; i<ArraySize(tl); i++ ) { Echelon( "EURCAD", tl[i] ); }
        for( i=0; i<ArraySize(tl); i++ ) { Echelon( "EURTRY", tl[i] ); }
                // for( i=0; i<ArraySize(tl); i++ ) { Echelon( "EURHKD", tl[i] ); }
        for( i=0; i<ArraySize(tl); i++ ) { Echelon( "GBPJPY", tl[i] ); }
        for( i=0; i<ArraySize(tl); i++ ) { Echelon( "GBPUSD", tl[i] ); }
        for( i=0; i<ArraySize(tl); i++ ) { Echelon( "GBPCHF", tl[i] ); }
        for( i=0; i<ArraySize(tl); i++ ) { Echelon( "AUDJPY", tl[i] ); }
        for( i=0; i<ArraySize(tl); i++ ) { Echelon( "AUDUSD", tl[i] ); }
        for( i=0; i<ArraySize(tl); i++ ) { Echelon( "AUDCAD", tl[i] ); }
        for( i=0; i<ArraySize(tl); i++ ) { Echelon( "AUDCHF", tl[i] ); }
        for( i=0; i<ArraySize(tl); i++ ) { Echelon( "AUDNZD", tl[i] ); }
        for( i=0; i<ArraySize(tl); i++ ) { Echelon( "NZDJPY", tl[i] ); }
        for( i=0; i<ArraySize(tl); i++ ) { Echelon( "NZDUSD", tl[i] ); }
        for( i=0; i<ArraySize(tl); i++ ) { Echelon( "NZDCAD", tl[i] ); }
        for( i=0; i<ArraySize(tl); i++ ) { Echelon( "NZDCHF", tl[i] ); }
                // for( i=0; i<ArraySize(tl); i++ ) { Echelon( "NZDSGD", tl[i] ); }
        for( i=0; i<ArraySize(tl); i++ ) { Echelon( "CHFJPY", tl[i] ); }
        for( i=0; i<ArraySize(tl); i++ ) { Echelon( "CADJPY", tl[i] ); }
        for( i=0; i<ArraySize(tl); i++ ) { Echelon( "CADCHF", tl[i] ); }
        for( i=0; i<ArraySize(tl); i++ ) { Echelon( "SGDJPY", tl[i] ); }
    }
    barsOld = barsNew;
    return(0);
}

/* ---------------------------------------
Echelon：取引期会を通知
---------------------------------------- */

bool Echelon( string s, int t ) {

    /*【 時間足による乖離率の振り分け 】*/
    switch(t) {
        case 1: //1分
            scopeGain = t * 55;
            scopeGapLightPosi = flexGain * 0.03;
            scopeGapHeavyPosi = flexGain * 0.12;
            scopeGapLightNega = flexGain * -0.02;
            scopeGapHeavyNega = flexGain * -0.12;
            break;
        case 5: //5分
            scopeGain = t * 22;
            scopeGapLightPosi = flexGain * 0.07;
            scopeGapHeavyPosi = flexGain * 0.28;
            scopeGapLightNega = flexGain * -0.07;
            scopeGapHeavyNega = flexGain * -0.28;
            break;
        case 15: //15分
            scopeGain = t * 12;
            scopeGapLightPosi = flexGain * 0.125 * 0.8;
            scopeGapHeavyPosi = flexGain * 0.5 * 1.4;
            scopeGapLightNega = flexGain * -0.125 * 0.8;
            scopeGapHeavyNega = flexGain * -0.5 * 1.4;
            break;
        case 30: //30分
            scopeGain = t * 9;
            scopeGapLightPosi = 0.4;
            scopeGapHeavyPosi = 0.8;
            scopeGapLightNega = -0.4;
            scopeGapHeavyNega = -0.8;
            scopeAdx = 13;
            break;
        case 60: //60分
            scopeGain = t * 6;
            scopeGapLightPosi = 0.2;
            scopeGapHeavyPosi = 1;
            scopeGapLightNega = -0.2;
            scopeGapHeavyNega = -1;
            scopeAdx = 13;
            break;
        case 240: //4時間
            scopeGain = t * 3;
            scopeGapLightPosi = 0.4;
            scopeGapHeavyPosi = 1.2;
            scopeGapLightNega = -0.4;
            scopeGapHeavyNega = -1.2;
            scopeAdx = 12;
            break;
        case 1440: //1日
            scopeGain = t * 2;
            scopeGapLightPosi = 0.6;
            scopeGapHeavyPosi = 1.8;
            scopeGapLightNega = -0.6;
            scopeGapHeavyNega = -1.8;
            scopeAdx = 12;
            break;
        case 10080: //1週間
            scopeGain = t * 1;
            scopeGapLightPosi = 3;
            scopeGapHeavyPosi = 14;
            scopeGapLightNega = -3;
            scopeGapHeavyNega = -14;
            scopeAdx = 13;
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
    double maNewA = iMA( s, t, 7, 0, MODE_SMA, PRICE_CLOSE, 0 );
    double maNewB = iMA( s, t, 13, 0, MODE_SMA, PRICE_CLOSE, 0 );
    double maNewC = iMA( s, t, 24, 0, MODE_SMA, PRICE_CLOSE, 0 );
    double maNewD = iMA( s, t, 44, 0, MODE_SMA, PRICE_CLOSE, 0 );
    double maNewE = iMA( s, t, 81, 0, MODE_SMA, PRICE_CLOSE, 0 );
    double maOldA = iMA( s, t, 7, 0, MODE_SMA, PRICE_CLOSE, 1 );
    double maOldB = iMA( s, t, 13, 0, MODE_SMA, PRICE_CLOSE, 1 );
    double maOldC = iMA( s, t, 24, 0, MODE_SMA, PRICE_CLOSE, 1 );
    double maOldD = iMA( s, t, 44, 0, MODE_SMA, PRICE_CLOSE, 1 );
    double maOldE = iMA( s, t, 81, 0, MODE_SMA, PRICE_CLOSE, 1 );

    // 一般に近いADX
    double adxMain1 = iCustom( s, t, "ADX", scopeAdx, 0, 0 ); // 今のADX
    double adxPlus1 = iCustom( s, t, "ADX", scopeAdx, 1, 0 ); // 今のプラスDI
    double adxMinus1 = iCustom( s, t, "ADX", scopeAdx, 2, 0 ); // 今のマイナスDI
    double adxOldMain1 = iCustom( s, t, "ADX", scopeAdx, 0, 1 ); // １つ前のADX
    double adxOldPlus1 = iCustom( s, t, "ADX", scopeAdx, 1, 1 ); // １つ前のマイナスDI
    double adxOldMinus1 = iCustom( s, t, "ADX", scopeAdx, 2, 1 ); // １つ前のマイナスDI
    // メタトレーダーのADX
    double adxMain2 = iADX( s, t, 13, PRICE_CLOSE, MODE_MAIN, 0 ); // 今のADX
    double adxPlus2 = iADX( s, t, 13, PRICE_CLOSE, MODE_PLUSDI, 0 ); // 今のプラスDI
    double adxMinus2 = iADX( s, t, 13, PRICE_CLOSE, MODE_MINUSDI, 0 ); // 今のマイナスDI
    double adxOldMain2 = iADX( s, t, 13, PRICE_CLOSE, MODE_MAIN, 1 ); // １つ前のADX
    double adxOldPlus2 = iADX( s, t, 13, PRICE_CLOSE, MODE_PLUSDI, 1 ); // １つ前のマイナスDI
    double adxOldMinus2 = iADX( s, t, 13, PRICE_CLOSE, MODE_MINUSDI, 1 ); // １つ前のマイナスDI

    // 一目均衡表
    double ichimokuA = iIchimoku( s, t, 9, 26, 52, MODE_SENKOUSPANA, 0 ); // 今の先行スパンA
    double ichimokuB = iIchimoku( s, t, 9, 26, 52, MODE_SENKOUSPANB, 0 ); // 今の先行スパンB
    double ichimokuOldA = iIchimoku( s, t, 9, 26, 52, MODE_SENKOUSPANA, 1 ); // 前の先行スパンA
    double ichimokuOldB = iIchimoku( s, t, 9, 26, 52, MODE_SENKOUSPANB, 1 ); // 前の先行スパンB
    double ichimokuT = iIchimoku( s, t, 9, 26, 52, MODE_TENKANSEN, 0 ); // 今の転換線
    double ichimokuOldT = iIchimoku( s, t, 9, 26, 52, MODE_TENKANSEN, 1 ); // 前の転換線
    double ichimokuK = iIchimoku( s, t, 9, 26, 52, MODE_KIJUNSEN, 0 );  // 基準線
    double ichimokuOldK = iIchimoku( s, t, 9, 26, 52, MODE_KIJUNSEN, 1 );  // 基準線
    double superLine = iMA( s, t, 1, 0, MODE_SMA, PRICE_CLOSE, 26 ); // 今の遅行スパン
    double superLineOld = iMA( s, t, 1, 0, MODE_SMA, PRICE_CLOSE, 27 ); // 前の遅行スパン
    double ichimokuC = iIchimoku( s, t, 9, 26, 52, MODE_CHINKOUSPAN, 26 ); // 遅行スパン
    double ichimokuOldC = iIchimoku( s, t, 9, 26, 52, MODE_CHINKOUSPAN, 27 ); // 遅行スパン

    // 移動平均線乖離率
    double maGapA = ( newClose - maNewA ) / maNewA * 100;
    double maGapE = ( newClose - maNewE ) / maNewE * 100;

    // 移動平均線の角度
    double maAngleA = ( MathArctan( maNewA - maOldA ) / 0.1 ) * ( 180 / 3.14 );
    double maAngleE = ( MathArctan( maNewE - maOldE ) / 0.1 ) * ( 180 / 3.14 );

    /* ------------------------------
    角度補正
    ------------------------------ */

    // if( t == 30 ) {
    //     if(s == "USDJPY") { maAngleA *= 2.58; }
    //     else if(s == "EURUSD") { maAngleA *= 202.89; }
    // }
    // else if( t == 60 ) {
    //     if(s == "USDJPY") { maAngleA *= 1.53; }
    // }
    // else if( t == 240) {
    //     if(s == "USDJPY") { maAngleA *= 0.52; }
    // }
    // else if( t == 1440) {
    //     if(s == "USDJPY") { maAngleA *= 0.469; }
    // }
    // else if( t == 10080 ) {
    //     if(s == "USDJPY") { maAngleA *= 0.159; }
    // }

    //if( s == "USDJPY" ) {
    //    switch(t) {
    //        case 30: maAngleA = MathAbs( maAngleA ) * 1.79;
    //        case 60: maAngleA = MathAbs( maAngleA ) * 1.53;
    //        case 240: maAngleA = maAngleA * 0.52;
    //        case 1440: maAngleA = maAngleA * 0.469;
    //        case 10080: maAngleA = maAngleA * 0.159;
    //        break;
    //    }
    //}
    //else if( s == "AUDJPY" ) {
    //    switch(t) {
    //        // case 60: maAngleA *= 1.55;
    //        // break;
    //    }
    //}

    // ADXの状態
    bool adxRise1 = adxMain1 >= adxMinus1 && adxOldMain1 < adxOldMinus1 && adxMain1 > adxOldMain1 && adxPlus1 > adxMinus1;
    bool adxRise2 = adxMain2 >= adxMinus2 && adxOldMain2 < adxOldMinus2 && adxMain2 > adxOldMain2 && adxPlus2 > adxMinus2;
    bool adxFall1 = adxMain1  >= adxPlus1 && adxOldMain1 < adxOldPlus1 && adxMain1 > adxOldMain1 && adxMinus1 > adxPlus1;
    bool adxFall2 = adxMain2  >= adxPlus2 && adxOldMain2 < adxOldPlus2 && adxMain2 > adxOldMain2 && adxMinus2 > adxPlus2;

    // 移動平均線がファン状態
    bool maUpperFan = maNewA > maNewB && maNewB > maNewC && maNewC > maNewD && maNewD > maNewE;
    bool maLowerFan = maNewA < maNewB && maNewB < maNewC && maNewC < maNewD && maNewD < maNewE;

    // 上昇トレンド
    bool trendUpper =
        ichimokuC > iClose( s, t, 26 ) && // 遅行スパンがバーより上
        ichimokuC > iIchimoku( s, t, 9, 26, 52, MODE_SENKOUSPANA, 26 ) && // 遅行スパンが雲より上
        ichimokuC > iIchimoku( s, t, 9, 26, 52, MODE_SENKOUSPANB, 26 ) && // 遅行スパンが雲より上
        ichimokuC > iMA( s, t, 7, 0, MODE_SMA, PRICE_CLOSE, 26 ) && // 遅行スパンが移動平均線より上
        ichimokuC > iMA( s, t, 13, 0, MODE_SMA, PRICE_CLOSE, 26 ) && // 遅行スパンが移動平均線より上
        ichimokuC > iMA( s, t, 24, 0, MODE_SMA, PRICE_CLOSE, 26 ) && // 遅行スパンが移動平均線より上
        ichimokuC > iMA( s, t, 44, 0, MODE_SMA, PRICE_CLOSE, 26 ) && // 遅行スパンが移動平均線より上
        ichimokuC > iMA( s, t, 81, 0, MODE_SMA, PRICE_CLOSE, 26 ) && // 遅行スパンが移動平均線より上
        ichimokuK < ichimokuT && // 転換線が基準線より上
        ichimokuK >= ichimokuOldK && // 基準線が上昇中
        newClose > maNewA && // 価格が移動平均線より上
        newClose > ichimokuA && // 価格が雲より上
        newClose > ichimokuB && // 価格が雲より上
        ichimokuA > ichimokuB; // 上昇雲

    // 下降トレンド
    bool trendLower =
        ichimokuC < iClose( s, t, 26 ) && // 遅行スパンがバーより下
        ichimokuC < iIchimoku( s, t, 9, 26, 52, MODE_SENKOUSPANA, 26 ) && // 遅行スパンが雲より下
        ichimokuC < iIchimoku( s, t, 9, 26, 52, MODE_SENKOUSPANB, 26 ) && // 遅行スパンが雲より下
        ichimokuC < iMA( s, t, 7, 0, MODE_SMA, PRICE_CLOSE, 26 ) && // 遅行スパンが移動平均線より下
        ichimokuC < iMA( s, t, 13, 0, MODE_SMA, PRICE_CLOSE, 26 ) && // 遅行スパンが移動平均線より下
        ichimokuC < iMA( s, t, 24, 0, MODE_SMA, PRICE_CLOSE, 26 ) && // 遅行スパンが移動平均線より下
        ichimokuC < iMA( s, t, 44, 0, MODE_SMA, PRICE_CLOSE, 26 ) && // 遅行スパンが移動平均線より下
        ichimokuC < iMA( s, t, 81, 0, MODE_SMA, PRICE_CLOSE, 26 ) && // 遅行スパンが移動平均線より下
        ichimokuK > ichimokuT && // 転換線が基準線より下
        ichimokuK <= ichimokuOldK && // 基準線が下降中
        newClose < maNewA && // 価格が移動平均線より下
        newClose < ichimokuA && // 価格が雲より下
        newClose < ichimokuB && // 価格が雲より下
        ichimokuA < ichimokuB; // 下降雲

    // 過去バー５本間で天井反動なし
    bool boundRoof =
        ( iHigh( s, t, 0 ) - maNewA ) / maNewA * 100 < scopeGapLightPosi*0.5 &&
        ( iHigh( s, t, 1 ) - maNewA ) / maNewA * 100 < scopeGapLightPosi*0.5 &&
        ( iHigh( s, t, 2 ) - maNewA ) / maNewA * 100 < scopeGapLightPosi*0.5 &&
        ( iHigh( s, t, 3 ) - maNewA ) / maNewA * 100 < scopeGapLightPosi*0.5 &&
        ( iHigh( s, t, 4 ) - maNewA ) / maNewA * 100 < scopeGapLightPosi*0.5;

    // 過去バー５本間で底反動なし
    bool boundFloor =
        ( iLow( s, t, 0 ) - maNewA ) / maNewA * 100 > scopeGapLightNega*0.5 &&
        ( iLow( s, t, 1 ) - maNewA ) / maNewA * 100 > scopeGapLightNega*0.5 &&
        ( iLow( s, t, 2 ) - maNewA ) / maNewA * 100 > scopeGapLightNega*0.5 &&
        ( iLow( s, t, 3 ) - maNewA ) / maNewA * 100 > scopeGapLightNega*0.5 &&
        ( iLow( s, t, 4 ) - maNewA ) / maNewA * 100 > scopeGapLightNega*0.5;

    // Zigzagの各頂点の値を取得
    int zcount = 0;
    double ZigZagVal[5];
    int ZigZagBar[5];

    for(int i=0; i<Bars; i++){
        double val = iCustom( s, t, "ZigZag", 0, i);
        if(val != 0.0){
            ZigZagVal[zcount] = val;
            ZigZagBar[zcount] = i;
            zcount++;
        if(zcount == 5) break;
        }
    }

    // 頂点の終値
    double zig1 = iClose( s, t, ZigZagBar[1] );
    double zig2 = iClose( s, t, ZigZagBar[2] );
    double zig3 = iClose( s, t, ZigZagBar[3] );
    double zig4 = iClose( s, t, ZigZagBar[4] );

    // ダブルボトムのネックライン突破
    //bool db = iClose( s, t, 0 ) > zig1 && zig1 < zig2 && zig2 > zig3 && zig3 < zig4 && iClose( s, t, 0) > zig2 && iClose( s, t, 1) < zig2 && iClose( s, t, 2) < zig2 && iClose( s, t, 3) < zig2;
    // ダブルトップのネックライン突破
    //bool dt = iClose( s, t, 0 ) < zig1 && zig1 > zig2 && zig2 < zig3 && zig3 > zig4 && iClose( s, t, 0 ) < zig2 && iClose( s, t, 1) > zig2 && iClose( s, t, 2) > zig2 && iClose( s, t, 3) > zig2;
    // ダブルボトム確定
    bool dbFix = iClose( s, t, 0 ) > zig1 && zig1 < zig2 && zig2 > zig3 && zig3 < zig4 && iOpen( s, t, 0) > zig2 && iOpen( s, t, 1) < zig2 && iOpen( s, t, 2) < zig2 && iOpen( s, t, 3) < zig2;
    // ダブルトップ確定
    bool dtFix = iClose( s, t, 0 ) < zig1 && zig1 > zig2 && zig2 < zig3 && zig3 > zig4 && iOpen( s, t, 0 ) < zig2 && iOpen( s, t, 1) > zig2 && iOpen( s, t, 2) > zig2 && iOpen( s, t, 3) > zig2;

    // メッセージ：パーフェクトオーダー
    string maStr;
    if( maUpperFan == true ) {
        maStr = "PO↑";
    } else if( maLowerFan == true ) {
        maStr = "PO↓";
    } else {
        maStr = "PO→";
    }

    // メッセージ：一目均衡表
    string clearStr;
    if( trendUpper == true ) {
        clearStr = "一目↑";
    } else if( trendLower == true ) {
        clearStr = "一目↓";
    } else {
        clearStr = "一目→";
    }

    // メッセージ：ADX
    string adxStr;
    if( adxMain1 > adxMinus1 && adxMain1 > adxOldMain1 && adxPlus1 > adxMinus1 ) {
        adxStr = "ADX↑";
    } else if( adxMain1 > adxPlus1 && adxMain1 > adxOldMain1 && adxMinus1 > adxPlus1 ) {
        adxStr = "ADX↓";
    } else {
        adxStr = "ADX→";
    }

    // 乖離倍率
    double kinkairiDown = MathRound( maGapA / scopeGapLightNega * 100 );
    double enkairiDown = MathRound( maGapE / scopeGapHeavyNega * 100 );
    double kinkairiUp = MathRound( maGapA / scopeGapLightPosi * 100 );
    double enkairiUp = MathRound( maGapE / scopeGapHeavyPosi * 100 );

    /*【 移動平均線乖離判定 】*/
    bool SignalGapDownA = maGapA < scopeGapLightNega && maGapE < scopeGapHeavyNega && iRSI( s, t, 14, 0, 0 ) < 25;
    bool SignalGapDownB = maGapA < scopeGapLightNega * 1.5 && maGapE < scopeGapHeavyNega && iRSI( s, t, 14, 0, 0 ) < 30;
    bool SignalGapUpA = maGapA > scopeGapLightPosi && maGapE > scopeGapHeavyPosi && iRSI( s, t, 14, 0, 0 ) > 75;
    bool SignalGapUpB = maGapA > scopeGapLightPosi * 1.5 && maGapE > scopeGapHeavyPosi && iRSI( s, t, 14, 0, 0 ) > 70;


    /* ------------------------------
    角度調査
    ------------------------------ */

    // if( s == "USDJPY" || s == "EURUSD") {
    //     SendNotification( StringConcatenate( s, "：", t, "：", "角度：", maAngleA ) );
    // }

    /* ------------------------------
    乖離率判定
    ------------------------------ */

    if ( maGapAlert == true ) {
        // 移動平均線の下方乖離を通知
        if( SignalGapDownA || SignalGapDownB ) {
            string maGapStrLower = StringConcatenate( s, "：", t, "分の乖離率で買い", "｜", "RSI：", MathRound( iRSI( s, t, 14, 0, 0 ) ), "｜", "近乖離：", kinkairiDown, "%", "｜", "遠乖離：", enkairiDown, "%", "｜", "角度：", maAngleA );
            SendNotification( maGapStrLower );
        }
        // 移動平均線の上方乖離を通知
        else if( SignalGapUpA || SignalGapUpB ) {
            string maGapStrUpper = StringConcatenate( s, "：", t, "分の乖離率で売り","｜", "RSI：", MathRound( iRSI( s, t, 14, 0, 0 ) ), "｜", "近乖離：", kinkairiUp, "%", "｜", "遠乖離：", enkairiUp, "%", "｜", "角度：", maAngleA );
            SendNotification( maGapStrUpper );
        }
    }

    /* ------------------------------
    チャートタイプ判定
    ------------------------------ */

    // ダブルボトムネックライン突破
    if ( typeAlert == true ) {
        // if( db ) {
        //  string dbStr = StringConcatenate( s, "：", t, "分のダブルボトムネックライン突破で買い", "｜", maStr, "｜", clearStr, "｜", adxStr );
        //  SendNotification( dbStr );
        //}
        // ダブルトップネックライン突破
        //else if (dt) {
        //  string dtStr = StringConcatenate( s, "：", t, "分のダブルトップネックライン突破で売り", "｜", maStr, "｜", clearStr, "｜", adxStr );
        //  SendNotification( dtStr );
        //}
        // ダブルボトム完成
        if( dbFix && kinkairiUp < 50 ) {
            string dbFixStr = StringConcatenate( s, "：", t, "分のダブルボトム確定で買い", "｜", maStr, "｜", clearStr, "｜", adxStr, "｜", "RSI：", MathRound( iRSI( s, t, 14, 0, 0 ) ), "｜", "近乖離：", kinkairiUp, "%" );
            SendNotification( dbFixStr );
        }
        // ダブルトップ完成
        else if( dtFix && kinkairiDown < 50 ) {
            string dtFixStr = StringConcatenate( s, "：", t, "分のダブルトップ確定で売り", "｜", maStr, "｜", clearStr, "｜", adxStr, "｜", "RSI：", MathRound( iRSI( s, t, 14, 0, 0 ) ), "｜", "近乖離：", kinkairiDown, "%");
            SendNotification( dtFixStr );
        }
    }

    /* ------------------------------
    ADXツインクロス判定
    ------------------------------ */

    if( adxAlert == true ) {
        if( adxRise1 && adxRise2 ) {
            string adxStrRise = StringConcatenate( s, "：", t, "分の２つのADXで強上昇クロス", "｜", maStr, "｜", clearStr, "｜", adxStr );
            SendNotification( adxStrRise );
        }
        if( adxFall1 && adxFall2 ) {
            string adxStrFall = StringConcatenate( s, "：", t, "分の２つのADXで強下降クロス", "｜", maStr, "｜", clearStr, "｜", adxStr );
            SendNotification( adxStrFall );
        }
    }

    /* ------------------------------
    雲のねじれ判定
    ------------------------------ */

    if( cloudCrossAlert == true ) {
        if( trendUpper ) {
            if( ichimokuOldA <= ichimokuOldB ) {
                string cloudStrUpper = StringConcatenate( s, "：", t, "分の雲が上昇交差", "｜", maStr, "｜", clearStr, "｜", adxStr );
                SendNotification( cloudStrUpper );
            }
        }
        if( trendLower ) {
            if( ichimokuOldA >= ichimokuOldB ) {
                string cloudStrLower = StringConcatenate( s, "：", t, "分の雲が下降交差", "｜", maStr, "｜", clearStr, "｜", adxStr );
                SendNotification( cloudStrLower );
            }
        }
    }

    /* ------------------------------
    スーパーライン判定
    ------------------------------ */

    if( superLineAlert == true ) {
        // 遅行スパンがバーを上抜いたとき
        if( ichimokuC > iClose( s, t, 26 ) && ichimokuOldC < iOpen( s, t, 26 ) && ichimokuC > ichimokuOldC ) {
            // ADXサインが上昇中のとき
            if( adxMain1 > adxMinus1 && adxMain1 > adxOldMain1 && adxPlus1 > adxMinus1 )
                // 価格・雲・移動平均線・遅行スパンの関係が上昇中サインのとき
                if( trendUpper )
                    // 通知
                    string superLineStrUpper = StringConcatenate( s, "：", t, "分のスーパーライン上昇クロス", "｜", maStr, "｜", clearStr, "｜", adxStr );
                    SendNotification( superLineStrUpper );
        }
        // 遅行スパンがバーを下抜いたとき
        else if( ichimokuC < iClose( s, t, 26 ) && ichimokuOldC > iOpen( s, t, 26 ) && ichimokuC < ichimokuOldC ) {
            // ADXサインが下降中のとき
            if( adxMain1 > adxPlus1 && adxMain1 > adxOldMain1 && adxMinus1 > adxPlus1 )
                // 価格・雲・移動平均線・遅行スパンの関係が下降中サインのとき
                if( trendLower )
                    // 通知
                    string superLineStrLower = StringConcatenate( s, "：", t, "分のスーパーライン下降クロス", "｜", maStr, "｜", clearStr, "｜", adxStr );
                    SendNotification( superLineStrLower );
        }
    }

    /* ------------------------------
    パーフェクトオーダー押し目判定
    ------------------------------ */

    // 価格・雲・移動平均線・遅行スパンの関係が上昇中サインのとき
    if( trendAlert == true ) {
        if( trendUpper && maUpperFan ) {
            // ADXが上昇中サインのとき
            if( adxMain1 > adxMinus1 && adxMain1 > adxOldMain1 && adxPlus1 > adxMinus1 ) {
                // 天井の反動がないとき、一つ前の高値が移動平均線より下、今は移動平均線より上
                if( boundRoof && ( iLow( s, t, 1 ) < maOldA || iLow( s, t, 0 ) < maOldA ) && iClose( s, t, 0) > maOldA )
                    // 通知
                    string trendUpperStr = StringConcatenate( s, "：", t, "分の上昇パーフェクトオーダー", "｜", maStr, "｜", clearStr, "｜", adxStr );
                    SendNotification( trendUpperStr );
            }
        }
        // 価格・雲・移動平均線・遅行スパンの関係が下降中サインのとき
        if( trendLower && maLowerFan ) {
            // ADXが下降中サインのとき
            if( adxMain1 > adxPlus1 && adxMain1 > adxOldMain1 && adxMinus1 > adxPlus1 ) {
                // 底の反動がないとき、一つ前の高値が移動平均線より上、今は移動平均線より下
                if( boundFloor && ( iHigh( s, t, 1 ) > maOldA || iHigh( s, t, 0 ) > maOldA ) && iClose( s, t, 0 ) < maOldA )
                    // 通知
                    string trendLowerStr = StringConcatenate( s, "：", t, "分の下降パーフェクトオーダー", "｜", maStr, "｜", clearStr, "｜", adxStr );
                    SendNotification( trendLowerStr );
            }
        }
    }

    return(0);
}
