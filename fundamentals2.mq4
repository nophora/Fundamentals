  //+------------------------------------------------------------------+
//|                                                          ERR.mq4 |
//|                        Copyright 2022, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2022, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
//+------------------------------------------------------------------+

//CPI = 5300
//NFP = 3800 TP = 14600
//RATES = 3800 TP = 14600
//PPI = 3800 TP =  14600



double sell_pric=(Bid-3800*_Point);
double buy_pric=(Ask+3800*_Point);
double lotsize=0.01;
int oders=1;
 
bool buystop=false;
bool sellstop=false;


void OnTick()
  {
  
  ObjectCreate(
  (int)Symbol(),
  "EventButton",
  OBJ_BUTTON,
  0,
  0,
  0
  );
  
  
  //event button
   ObjectSetInteger((int)Symbol(),"EventButton",OBJPROP_XDISTANCE,30);
   ObjectSetInteger((int)Symbol(),"EventButton",OBJPROP_YDISTANCE,300);
   ObjectSetInteger((int)Symbol(),"EventButton",OBJPROP_XSIZE,120);
   ObjectSetInteger((int)Symbol(),"EventButton",OBJPROP_YSIZE,50);
   ObjectSetInteger((int)Symbol(),"EventButton",OBJPROP_CORNER,4);
   ObjectSetString((int)Symbol(),"EventButton",OBJPROP_TEXT,"EVENT");
   ObjectSetInteger((int)Symbol(),"EventButton",OBJPROP_COLOR,clrRed);
   ObjectSetInteger((int)Symbol(),"EventButton",OBJPROP_FONTSIZE,10);
   
  
  
 
  //if sell_stop has been triggered
  if((OrdersTotal()>0&&Bid<=sell_pric)&&buystop==false){
    buystop=true;
    sellstop=true;
    for(int i=OrdersTotal()-1;i>=0;i--)
     {
      if(OrderSelect(i,SELECT_BY_POS)==false) continue;
        if(OrderType()==OP_BUYSTOP){
         Print("its an BUYSTOP");
         bool result=OrderDelete(OrderTicket());
      {
         if(!result)
           {
             Print("OrderCloseError! Ticket: "+IntegerToString(OrderTicket()));
           }
       }
          
        
     }
     }
    
   };
  
  
  
  //if buy_stop has been triggered
  if((OrdersTotal()>0&&Ask>=buy_pric)&&sellstop==false){
    buystop=true;
    sellstop=true;
     for(int i=OrdersTotal()-1;i>=0;i--)
     {
      if(OrderSelect(i,SELECT_BY_POS)==false) continue;
        if(OrderType()==OP_SELLSTOP){
         Print("its an SELLSTOP");
         bool result=OrderDelete(OrderTicket());
      {
         if(!result)
           {
             Print("OrderCloseError! Ticket: "+IntegerToString(OrderTicket()));
           }
       }
          
        
     }
     }
  };
 
  };
  
   
  
 
 

void OnChartEvent(const int id, const long& lparam,const double& dparam,const string& sparam  ) 
  { 
 
 if(id==CHARTEVENT_OBJECT_CLICK){
 
  if(sparam=="EventButton"){
 buystop=false;
 sellstop=false;
 sell_pric=(Bid-3800*_Point);
 buy_pric=(Ask+3800*_Point);
 if(OrdersTotal()==0)
   for (int i = 0; i <oders; i++) {
   
   int buyticket = OrderSend(
   Symbol(),
   OP_BUYSTOP,
   lotsize,
   buy_pric,
   3,//slippage in Point
   0, //stop loss
   (Ask+14600*_Point), //take profit
   NULL, //no comment
   0, //magic number
   0, //expiration date
   Red //arrow color
   );
   
    int sellticket = OrderSend(
   Symbol(),
   OP_SELLSTOP,//set sell stop
   lotsize, //lot size
   sell_pric, //entry price
   3,/*slippage in Point*/
   0, //stop loss
   (Bid-14600*_Point), //take profit
   NULL, //no comment
   0, //magic number
   0, //expiration date
   Red  //arrow color
   );
};

 // return(INIT_SUCCEEDED); 
   }
   }
  };

 






