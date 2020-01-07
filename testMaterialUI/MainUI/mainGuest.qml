import QtQuick 2.3
import QtQuick.Window 2.2
import QtQuick.Controls 1.4
import QtGraphicalEffects 1.0
import "qrc:/MaterialUI/"
import "qrc:/MaterialUI/Interface/"


Window {
    visible: true
    id:applicationWindow
    x:800
    y:0
    width: 600
    height: 400
    color: "#fafafa"
    opacity: 100
    title: "客显界面"

    MaterialLabel{
        id:labelForCurrentItemTitleName
        x:60
        z:1
        height: 64
        font.pixelSize: 20
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.left
        color: "#000000"
        text: "客显界面"
    }

}
















