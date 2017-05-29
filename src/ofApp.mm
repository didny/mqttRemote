#include "ofApp.h"

//--------------------------------------------------------------
void ofApp::setup(){
   ofBackground(0);
   ofSetVerticalSync(true);
   ofEnableSmoothing();
   
   serverAddress = setting.getString("IPAddress");
   serverPort = setting.getInt("Port");
   userName = setting.getString("username");
   password = setting.getString("password");
   
   string topic = setting.getString("Topic");
   
   int rows = 4;
   int cols = 2;
   
   for (int i=0; i < rows;  i++) {
      for (int j= 0; j < cols; j++) {
         int btnId = i*cols+j;
         string key ="T"+ofToString(btnId);
         string val = setting.getString(key);
         
         //if(!val.compare("")){
            val = topic+ofToString(btnId);
            setting.setString(val,key);
            cout << "insert test topic key: " << key << "val: " << val << endl;
         //}

         topicDict.insert(make_pair(key,val));
      }
   }
   
   for (int i=0; i < rows;  i++) {
      for (int j= 0; j < cols; j++) {
         string key ="T("+ofToString(j)+","+ofToString(i)+")";
         string val = setting.getString("T"+ofToString(i*cols+j));
         cout << "insert topicDict key: " << key << "val: " << val << endl;
         topicDict.insert(make_pair(key,val));
      }
   }

   client.begin(serverAddress, serverPort);
   
   client.connect("mqttRemote", "try", "try");
   ofAddListener(client.onOnline, this, &ofApp::onOnline);
   ofAddListener(client.onOffline, this, &ofApp::onOffline);
   ofAddListener(client.onMessage, this, &ofApp::onMessage);
   
   ui = new ofxUICanvas(ofGetWidth(),ofGetHeight());
   ui->setDrawBack(false);
   //ui->addSpacer();
   //ui->setColorBack(OFX_UI_COLOR_BACK);
   ui->setWidgetSpacing(4);
   ui->setPadding(4);
   
   ui->setFont("Questrial-Regular.ttf");                     //This loads a new font and sets the GUI font
   ui->setFontSize(OFX_UI_FONT_LARGE, 18);            //These call are optional, but if you want to resize the LARGE, MEDIUM, and SMALL fonts, here is how to do it.
   ui->setFontSize(OFX_UI_FONT_MEDIUM, 14);
   ui->setFontSize(OFX_UI_FONT_SMALL, 10);            //SUPER IMPORTANT NOTE: CALL THESE FUNTIONS BEFORE ADDING ANY WIDGETS, THIS AFFECTS THE SPACING OF THE GUI


   ofxUIRectangle * canvasSize = ui->getRect();
   float w = canvasSize->getWidth();
   float h = canvasSize->getHeight();
   
  // string name = "B";
   float offset = ui->getWidgetSpacing();
   float offsetX = offset*4+ui->getPadding()*(cols-1);
   float offsetY = offset*4+ui->getPadding()*(rows-1);
   float btnWidth = (w-offsetX)/cols;
   float btnHeight = (h-offsetY)/rows;
   

   ui->setWidgetPosition(OFX_UI_WIDGET_POSITION_DOWN,OFX_UI_ALIGN_CENTER);
   ofxUILabelToggleMatrix *tglMtx = ui->addLabelToggleMatrix("T", rows, cols,btnWidth,btnHeight);
   tglMtx->setFont(ui->getFontSmall());
   tglMtx->setLabelVisible(true);
   
   //ofColor paddingColor = ofColor(255,0,0,200);
   
  /* ui->setWidgetPosition(OFX_UI_WIDGET_POSITION_DOWN,OFX_UI_ALIGN_CENTER);
   ofxUILabelToggleMatrix *tglMtx = new ofxUILabelToggleMatrix(btnWidth,btnHeight,rows,cols,"T");
   //tglMtx->setParent(ui);
   ui->addWidgetDown(tglMtx);*/
   
    //ofColor paddingColor = ofColor(255,0,0,200);
   
   
   
/* TEST Add Label Button Matrix*/
 /*   for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
    string val = "B"+ofToString(i*cols+j);

    ofxUILabelButton *lblButton = new ofxUILabelButton(val,false,btnWidth,btnHeight);
    
    //lblButton->setColorPadded(paddingColor);
    lblButton->setEmbedded(true);
    
    if(i == 0 && j == 0) ui->addWidgetDown(lblButton,OFX_UI_ALIGN_LEFT);
    else if(j == 0) ui->addWidgetSouthOf(lblButton, "B"+ofToString((i-1)*cols));
    else ui->addWidgetEastOf(lblButton, "B"+ofToString(i*cols+(j-1)));
    
    
    }}*/
    
 /*
   for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
         bool *val = new bool();
         *val = false;
         ofxUIButton *lblButton = new ofxUILabelButton("B"+ofToString(i*cols+j),val,btnWidth,btnHeight);
         
         //lblButton->setColorPadded(paddingColor);
         lblButton->setEmbedded(true);
         
         if(i == 0 && j == 0) ui->addWidgetDown(lblButton,OFX_UI_ALIGN_LEFT);
         else if(j == 0) ui->addWidgetSouthOf(lblButton, "B"+ofToString((i-1)*cols));
         else ui->addWidgetEastOf(lblButton, "B"+ofToString(i*cols+(j-1)));
         
         
      }
   }*/

   
   //ui->centerWidgetsOnCanvas();
   ofAddListener(ui->newGUIEvent,this,&ofApp::guiEvent);
   
}

void ofApp::addUIMatrix(){
    //vector<ofxUILabelButton *> buttons;
    
    //   for(int j = 0; j < rows; j++)
    //   {
    //      for(int i = 0; i < cols; i++)
    //      {
    //          bool *val = new bool();
    //         ofxUILabelButton *btn = new ofxUILabelButton((name+"("+ofxUIToString(i,0)+","+ofxUIToString(j,0)+")"), val,  btnWidth, btnHeight, i*btnWidth+offset*i, j*btnHeight+offset*j, OFX_UI_FONT_SMALL);
    //
    ////         //btn->setLabelVisible(false);
    //         ui->addWidget(btn);
    ////         /*if(i == 0 && j ==0) ui->addWidgetDown(btn);
    ////         else if(i == 0){
    ////            ui->addWidgetSouthOf(btn,name+"("+ofxUIToString(i,0)+","+ofxUIToString(j-1,0)+")");
    ////         }
    ////         else ui->addWidgetRight(btn);*/
    ////         buttons.push_back(btn);
    //         //ui->addLabelButton(name+"("+ofxUIToString(i,0)+","+ofxUIToString(j,0)+")",false);
    //        // bool *b = new Bool();
    //         //ui->addLabelButton(name+ofxUIToString(i,0)+ofxUIToString(j,0),false);
    //      }
    //   }
}

//--------------------------------------------------------------
void ofApp::update() {
   //client.update();
//   gui.update();
}
//--------------------------------------------------------------
void ofApp::draw() {
   ofBackground(50,0,0);
	//gui.draw();
}

void ofApp::guiEvent(ofxUIEventArgs &e)
{
   string name = e.widget->getName();
   int kind = e.widget->getKind();
    cout << e.widget->getName() << endl;
   
   map<string,string>::iterator it = topicDict.find(name);
   
   if(it != topicDict.end())
   {
      ofxUIToggle *button = (ofxUIToggle *) e.widget;
      cout << "key: " << it->first << "value: " << it->second << endl;
      client.publish(it->second,ofToString(button->getValue()));
   }
   
}


//--------------------------------------------------------------
void ofApp::exit(){
   client.disconnect();
    delete ui;
}

//--------------------------------------------------------------
void ofApp::onOnline(){
   ofLog() << "online";
   
   client.subscribe("hello");
}

//--------------------------------------------------------------
void ofApp::onOffline(){
   ofLog() << "offline";
}

//--------------------------------------------------------------
void ofApp::onMessage(ofxMQTTMessage &msg){
   ofLog() << "message: " << msg.topic << " - " << msg.payload;
}


//--------------------------------------------------------------
void ofApp::touchDown(ofTouchEventArgs & touch){
   
}

//--------------------------------------------------------------
void ofApp::touchMoved(ofTouchEventArgs & touch){
   
}

//--------------------------------------------------------------
void ofApp::touchUp(ofTouchEventArgs & touch){
   
}

//--------------------------------------------------------------
void ofApp::touchDoubleTap(ofTouchEventArgs & touch){
   
}

//--------------------------------------------------------------
void ofApp::touchCancelled(ofTouchEventArgs & touch){
   
}

//--------------------------------------------------------------
void ofApp::lostFocus(){
   
}

//--------------------------------------------------------------
void ofApp::gotFocus(){
   
}

//--------------------------------------------------------------
void ofApp::gotMemoryWarning(){
   
}

//--------------------------------------------------------------
void ofApp::deviceOrientationChanged(int newOrientation){
   
}

