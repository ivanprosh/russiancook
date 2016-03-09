import QtQuick 2.2
import QtQuick.Window 2.0

Item
{
    property int dpi: Screen.pixelDensity * 25.4
 
    function dp(x){
        if(Qt.platform.os == "windows") {
            console.log("windows")
            return x; // для обычного монитора компьютера
        } else {
            console.log("not windows")
            return x*(dpi/160);
        }
    }
}
