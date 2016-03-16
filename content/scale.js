var dpi= 25.4 * Screen.pixelDensity;

function dp(x){
    if(Qt.platform.os == "windows") {

        return x*dpi; // для обычного монитора компьютера
    } else {
        return x*(dpi/160);
    }
}
