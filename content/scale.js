var dpi= Screen.pixelDensity * 25.4
 
function dp(x){
    //if(dpi<120) {
    if(Qt.platform.os == "windows") {
        return x; // для обычного монитора компьютера
    } else {
        return x*(dpi/160);
    }
}
