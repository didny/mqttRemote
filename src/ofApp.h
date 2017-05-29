#pragma once
#define OFX_UI_NO_XML 1

#include "ofMain.h"
#include "ofxiOS.h"
#include "ofxiOSExtras.h"
#include "ofxUI.h"
#include "ofxMQTT.h"
#include "ofxXmlSettings.h"
//#include "ofxKCTouchGUI.h"
#include "Settings.h"


class ofApp : public ofxiOSApp {
public:
   ofxMQTT client;
   void setup();
   void update();
   void draw();
   void exit();
   
   void touchDown(ofTouchEventArgs & touch);
   void touchMoved(ofTouchEventArgs & touch);
   void touchUp(ofTouchEventArgs & touch);
   void touchDoubleTap(ofTouchEventArgs & touch);
   void touchCancelled(ofTouchEventArgs & touch);
   
   void lostFocus();
   void gotFocus();
   void gotMemoryWarning();
   void deviceOrientationChanged(int newOrientation);
   
   void onOnline();
   void onOffline();
   void onMessage(ofxMQTTMessage &msg);
    
   void addUIMatrix();
   
   Settings setting;
   string serverAddress;
   int serverPort;
   string userName;
   string password;
   
   
   ofxUICanvas *ui;
   void guiEvent(ofxUIEventArgs &e);
   bool drawPadding;
   
   std::map<string, string>  topicDict;

   ofxXmlSettings * xmlSettings;
   //ofxUILabelToggleMatrix
    

};


