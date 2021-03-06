import QtQuick 2.12


  Item{
    id: homepage  
  

    
    Rectangle {
        id: main
        color: mainCSS.background
        width: wrapperCSS.width
        height: mainCSS.height + headerHeightCorrection  // Zoom option
        anchors.top: parent.top
        
        
        Rectangle{
          id:systems
          color:"transparent"
          anchors.left: parent.left
          anchors.right: parent.right
          anchors.top: parent.top
          height: main.height-anchors.topMargin
          width: 640
          //anchors.leftMargin: 64;
          //anchors.topMargin: headerHeightCorrection === 0 ? 0 : 24 ;
          
              ListView{
                id: systemsListView
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: systems.top
                anchors.bottom: parent.bottom
                model: allCollections
                delegate: systemsDelegate  
                orientation: ListView.Horizontal

                
                
                focus: currentPage === 'HomePage' ? true : false ;
                highlightRangeMode: ListView.StrictlyEnforceRange
                preferredHighlightBegin: 0
                preferredHighlightEnd: vpx(1057)
                snapMode: ListView.SnapToItem
                highlightMoveDuration: 300
                highlightMoveVelocity: -1
                keyNavigationWraps: true     
                // snapMode: ListView.SnapOneItem
                // highlightRangeMode: ListView.StrictlyEnforceRange                
                 Keys.onLeftPressed: {  decrementCurrentIndex(); navSound.play(); } 
                 Keys.onRightPressed: {  incrementCurrentIndex(); navSound.play();  }
      
                  Component {
                      id: systemsDelegate
                   
                   
                      Item {
                          id: systems__item_container
                          width: 640
                          height: 480
                          // anchors.top: parent.top
                          
                          Keys.onPressed: {
                            if (api.keys.isAccept(event)) {
                                event.accepted = true;
                                
                                //We update the collection we want to browse
                                currentCollectionIndex = systems__item_container.ListView.view.currentIndex
                                //We change Pages
                                navigate('ListPage');
                                
                                return;
                            }      
                            if (api.keys.isFilters(event)) {
                                event.accepted = true;
                                toggleZoom();
                                return;
                            }  
                            // if (api.keys.isDetails(event)) {
                            //     event.accepted = true;
                            //     toggleZoom();
                            //     return;
                            // }  

                                    
                          }       
                          
                                             
                          
                          Text {
                              id: systems__item_title
                              text: modelData.name
                              anchors.top: parent.top
                              color: theme.accent
                              font.pixelSize: 18
                              font.bold: true
                              font.family: titleFont.name
                              height: 0
                              verticalAlignment: Text.AlignVCenter
                              elide: Text.ElideRight
                              width: systems.height-systems__item_title.height
                              opacity: systems__item_container.ListView.isCurrentItem ? 1 : 0
                              visible: false
                          }
                          
                          Rectangle {
                              id: systems__item
                              width: parent.width
                              height: parent.height       
                              
                              anchors.top : systems__item_title.bottom
  
  
  
                              Rectangle{
                                id: systems__item_inner
                                anchors.top: systems__item.top
                                anchors.left: systems__item.left
                                // anchors.topMargin: 4
                                // anchors.leftMargin: 4
                                width: parent.width
                                height: parent.height
                                // border.color: systems__item_container.ListView.isCurrentItem ? "white" : wrapperCSS.background
                                // border.width: 4     
                                color:"transparent"    
                                
                                Image {
                                    id: systems__img_bg
                                    width: parent.width      
                                    fillMode: Image.PreserveAspectCrop
                                    source: "../assets/images/systems-bg/"+modelData.shortName+".jpg"
                                    asynchronous: true                                       
                                }     
                                
                                Rectangle{
                                  id: systems__overlay
                                  width: parent.width
                                  height: parent.height
                                  color:"#000"
                                  opacity:.3
                                }
                                
                                  Canvas {
                                      id: leftColor
                                      // canvas size
                                      width: 640; height: 480;
                                      opacity:1
                                      // handler to override for drawing
                                      onPaint: {
                                          // get context to draw with
                                          var ctx = getContext("2d")
                                          var gradient = ctx.createLinearGradient(100,0,100,200)
                                          gradient.addColorStop(0, systemGradients[modelData.shortName])
                                          gradient.addColorStop(0.5, systemGradients[modelData.shortName]) 
                                          // setup the fill
                                          ctx.fillStyle = gradient
                                          // begin a new path to draw
                                          ctx.beginPath()
                                          // top-left start point
                                          ctx.moveTo(0,0)
                                          // upper line
                                          ctx.lineTo(205,0)
                                          // right line
                                          ctx.lineTo(45,480)
                                          // bottom line
                                          ctx.lineTo(0,480)
                                          // left line through path closing
                                          ctx.closePath()
                                          // fill using fill style
                                          ctx.fill()
                                      }
                                  }
                                  Canvas {
                                      id: leftGradient
                                      // canvas size
                                      width: 640; height: 480;
                                      opacity:0.8
                                      // handler to override for drawing
                                      onPaint: {
                                          // get context to draw with
                                          var ctx = getContext("2d")
                                          var gradient = ctx.createLinearGradient(100,0,100,600)
                                          gradient.addColorStop(0, "transparent")
                                          gradient.addColorStop(.7, Qt.darker(systemGradients[modelData.shortName])) 
                                          // setup the fill
                                          ctx.fillStyle = gradient
                                          // begin a new path to draw
                                          ctx.beginPath()
                                          // top-left start point
                                          ctx.moveTo(0,0)
                                          // upper line
                                          ctx.lineTo(205,0)
                                          // right line
                                          ctx.lineTo(45,480)
                                          // bottom line
                                          ctx.lineTo(0,480)
                                          // left line through path closing
                                          ctx.closePath()
                                          // fill using fill style
                                          ctx.fill()
                                      }
                                  }
                                  
                                  
                                  Canvas {
                                      id: rightColor
                                      // canvas size
                                      width: 640; height: 480
                                      // handler to override for drawing
                                      opacity:1
                                      onPaint: {
                                          // get context to draw with
                                          var ctx = getContext("2d")
                                          var gradient = ctx.createLinearGradient(100,0,100,200)
                                          gradient.addColorStop(0, systemGradients[modelData.shortName])
                                          gradient.addColorStop(1, systemGradients[modelData.shortName]) 
                                          // setup the fill
                                          ctx.fillStyle = gradient
                                          // begin a new path to draw
                                          ctx.beginPath()
                                          // top-left start point
                                          ctx.moveTo(415,0)
                                          // upper line
                                          ctx.lineTo(640,0)
                                          // right line
                                          ctx.lineTo(640,480)
                                          // bottom line
                                          ctx.lineTo(265,480)
                                          // left line through path closing
                                          ctx.closePath()
                                          // fill using fill style
                                          ctx.fill()
                                      }
                                  }
                                  
                                  Canvas {
                                      id: rightGradient
                                      // canvas size
                                      width: 640; height: 480
                                      // handler to override for drawing
                                      opacity:0.8
                                      onPaint: {
                                          // get context to draw with
                                          var ctx = getContext("2d")
                                          var gradient = ctx.createLinearGradient(100,0,100,600)
                                          gradient.addColorStop(0, "transparent")
                                          gradient.addColorStop(.7, Qt.darker(systemGradients[modelData.shortName])) 
                                          // setup the fill
                                          ctx.fillStyle = gradient
                                          // begin a new path to draw
                                          ctx.beginPath()
                                          // top-left start point
                                          ctx.moveTo(415,0)
                                          // upper line
                                          ctx.lineTo(640,0)
                                          // right line
                                          ctx.lineTo(640,480)
                                          // bottom line
                                          ctx.lineTo(265,480)
                                          // left line through path closing
                                          ctx.closePath()
                                          // fill using fill style
                                          ctx.fill()
                                      }
                                  }
                                  
                                  Image {
                                      id: systems__img_mascot
                                      width: 300 
                                      height: 400   
                                      sourceSize { width: 300; }                                    
                                      fillMode: Image.PreserveAspectFit
                                      source: {
                                          if (modelData.shortName.includes("all")) {
                                              return ""
                                          } else {
                                              return "../assets/images/mascot/"+modelData.shortName+".png"
                                          }
                                      }
                                      asynchronous: true      
                                      anchors.bottom: parent.bottom                                 
                                      anchors.left: parent.left    
                                      anchors.bottomMargin: 0    
                                      anchors.leftMargin: 40   
                                    }                                  
                                  
                                  
                                  Image {
                                      id: systems__img_logos
                                      width: 200    
                                      sourceSize { width: 200; }                                    
                                      fillMode: Image.PreserveAspectCrop
                                      source: {
                                          if (modelData.shortName.includes("all")) {
                                              return ""
                                          } else {
                                              return "../assets/images/logos/"+modelData.shortName+".png"
                                          }
                                      }
                                      asynchronous: true      
                                      anchors.bottom: parent.bottom                                 
                                      anchors.right: parent.right    
                                      anchors.bottomMargin: 100    
                                      anchors.rightMargin: 40  
                                      visible: currentPage === 'HomePage' ? true : false ;
                                  }     
                                  
                                  Text{
                                      text:modelData.name
                                      color:"White"
                                      anchors.bottom: parent.bottom                                 
                                      anchors.right: parent.right    
                                      anchors.bottomMargin: 100    
                                      anchors.rightMargin: 40  
                                      font.pixelSize:40
                                      visible: modelData.shortName.indexOf('all-')>-1 ? true: false
                                      font.family: globalFonts.condensed
                                  }
                                                                                                                     
                                                                                 
                              }
   
                                                                                  
                          }
                     
                
                      }
                  }      
                  
                
              }
        }
  
          
    }  
    
    //  Footer{
    //   id: footer
    // }   

}