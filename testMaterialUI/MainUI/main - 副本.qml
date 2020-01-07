import QtQuick 2.3
import QtQuick.Window 2.2
import QtQuick.Controls 1.4
import QtGraphicalEffects 1.0
import "qrc:/MaterialUI/"
import "qrc:/MaterialUI/Interface/"


Window {
    visible: true
    id:applicationWindow
    x:0
    y:0
    width: 800
    height: 600
    color: "#fafafa"
    opacity: 0


    Component.onCompleted: {
        animationForOpacity.start();

        listViewForBookmark.refresh([{bookmarkName:"首页",titleName:"首页",qrcLocation:"qrc:/Welcome.qml",
                                     children:[]},
                                     {
                                         bookmarkName:"文本类",titleName:"文本类",children:
                                             [{ bookmarkName:"JSon",titleName:"ddd",qrcLocation:
                                                 "qrc:/json.qml"
                                             }
                                         ]
                                     }

                                    ]);

        itemForMainPage.showPage("首页","qrc:/Welcome.qml");

    }

    NumberAnimation {
            id: animationForOpacity
            target: applicationWindow
            property: "opacity"
            easing.type: Easing.OutSine
            duration: 300
            to: 1
        }

    Rectangle {
        x: 0
        y: 0
        z: 1
        width: 180
        height: 64
    }

    //顶部阴影效果
    RectangularGlow{
        x:180
        z:-1
        width: parent.width -180
        height: 64
        glowRadius: 5
        spread: 0.22
        color: "#300000000"
        cornerRadius: 5
    }


    //顶端标题
    Rectangle{
        x:180
        z:1
        width: parent.width-180
        height: 64
        color: "#2196f3"

        MaterialLabel{
            id:labelForCurrentItemTitleName
            x:60
            z:1
            height: 64
            font.pixelSize: 20
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.left
            color: "#ffffff"
        }

        MouseArea{

        }

        //版本信息
        MaterialLabel{
            id:labelForVersionString

        }
    }


   //横线
    Rectangle{
        x:0
        y:63
        z:1
        width: 180
        height: 2
        color: "#e1e1e1"
    }


    //顶部log区域
    MaterialLabel {
           z: 1
           width: 180
           height: 64
           text: "BOM系统"
           font.pixelSize: 20
           verticalAlignment: Text.AlignVCenter
           horizontalAlignment: Text.AlignHCenter
           color: "#757575"
       }

    //左侧菜单背景
    Rectangle {
        y: 64
        width: 180
        height: parent.height - 64
        color: "#ffffff"
    }

    //菜单
    ListView{
        id:listViewForBookmark
        y:64
        width: 180
        height: parent.height -64
        cacheBuffer: 9999

        model: ListModel{
            id:listModelForBookmark
        }

        delegate: Item{
            id:itemForBookmark
            width: listViewForBookmark.width
            height: 42
            clip: true

            Behavior on height {NumberAnimation{easing.type: Easing.InOutQuad;duration: 400}}

            Component.onCompleted: {
                for(var index = 0; index < bookmarkChildrentItem.count;index++)
                {
                    var buf = bookmarkChildrenItem.get(index);
                    listModelForSecondBookmark.append({
                                                          bookmarkName:buf["bookmarkName"],
                                                          titleName:buf["titleName"],
                                                          itemQrcLocation:buf["qrcLocation"]
                                                      });


                }
            }

            Item{
                x:0
                y:42
                width: parent.width
                height: listViewForSecondBookmark.height
                clip:true
                ListView{
                    id:listViewForSecondBookmark
                    x:0
                    y:0
                    width: parent.width
                    height: 0
                    visible: y!== (-1*listViewForSecondBookmark.height)

                    Behavior on y {NumberAnimation{easing.type: Easing.InOutQuad; duration: 400}}

                    model:ListModel{
                        id:listModelForSecondBookmark
                    }

                    delegate: Item{
                        id:itemForSecondBookmark
                        width: listViewForBookmark.width
                        height: 42

                        MaterialButton{
                            anchors.fill: parent
                            elevation: 0
                            text: ""
                            visible: listViewForBookmark.y === 0

                            MaterialLabel{
                                x:36
                                height: parent.height
                                font.pixelSize: 15
                                verticalAlignment: Text.AlignVCenter
                                //color:

                                Behavior on color { ColorAnimation { duration: 200 }}
                            }
                            onClicked: {
                                itemForMainPage.showPage(titleName,itemQrcLocation);
                            }
                        }

                        Rectangle{
                            anchors.fill: parent
                            color: "#ffffff"
                            visible: listViewForSecondBookmark.y !== 0

                            MaterialLabel{
                                x:36
                                height: parent.height
                                text: bookmarkName
                                font.pixelSize: 16
                                verticalAlignment: Text.AlignVCenter
                            }
                        }//Rectangle
                    }//item
                }//listview
            }//item

            MaterialButton{
                width: parent.width
                height: 42
                elevation: 0
                textHorizontalAlignment: Text.AlignLeft

                onClicked: {
                    itemForMainPage.showPage(titleName,itemQrcLocation);

                    if(listModelForSecondBookmark.count)
                    {
                        if(listViewForSecondBookmark.visible)
                        {
                            listViewForSecondBookmark.y = -1* listViewForSecondBookmark.height;
                            itemForBookmark.height = 42
                        }
                        else{
                            itemForBookmark.height = 0
                            itemForBookmark.height = 42+ listViewForBookmark.height;
                        }
                    }
                }

                MaterialLabel{
                    x:18
                    height: parent.height
                    text: bookmarkName
                    font.bold: true
                    verticalAlignment: Text.AlignVCenter
                    font.pixelSize: 16
//                    color: (labelForcu)
                    Behavior on color { ColorAnimation { duration: 200 } }
                }

            }//MaterialButton
        }//delegate

        function refresh(items){
            listModelForBookmark.clear()

            for(var index =0; index < items.length;index++)
            {
                listModelForBookmark.append({
                                                bookmarkName:items[index]["bookmarkName"],
                                                titleName:items[index]["titleName"],
                                                itemQrcLocation: items[index]["qrcLocation"],
                                                bookmarkChildrenItem: items[index]["children"]
                                            });

            }

        }

        MouseArea{
            anchors.fill: parent
            acceptedButtons: Qt.MidButton

            onWheel: {

            }
        }//MouseArea
    }//菜单

    Rectangle{
        x:180
        y:0
        z:1
        height: parent.height
        color:"#dcdc00"
    }


    Item {
        id: itemForMainPage
        x:180
        y:64
        z:-2
        width: parent.width -180
        height: parent.height-64

        property var pages: new Object

        function showPage(titleName,itemQrcLocation)
        {
            showPageTimer.titleName = titleName;
            showPageTimer.itemQrcLocation = itemQrcLocation;
            console.log("->",titleName,itemQrcLocation);
            showPageTimer.start();
        }


        Timer{
            id: showPageTimer
            interval: 5
            repeat: false
            running: false
            property string titleName
            property string itemQrcLocation

            onTriggered: {
                switch(itemQrcLocation)
                {
                case "":break;
                default:
                    if(!(itemQrcLocation in itemForMainPage.pages))
                    {
                        var component = Qt.createComponent(itemQrcLocation);
                        if(Component.Ready=== component.status)
                        {
                            var page = component.createObject(itemForMainPage);
                            page.anchors.fill = itemForMainPage;
                            itemForMainPage.pages[itemQrcLocation]= page;
                            console.log("page created");
                        }
                    }

                    for(var key in itemForMainPage.pages)
                    {
                        itemForMainPage.pages[key].visible = false;
                    }

                    itemForMainPage.pages[itemQrcLocation].visible = true;
                    console.log("-->"+ itemQrcLocation);
                    break;
                }
            }//onTriggered
        }//Timer
    }//Item


    //dialog
    MaterialUI{
        id:materialUI
        z:2
        anchors.fill: parent
        dialogCancelText: "取消"
        dialogOKText: "确定"
    }
}
















