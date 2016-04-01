unix:!android {
    isEmpty(target.path) {
        qnx {
            target.path = /tmp/$${TARGET}/bin
        } else {
            target.path = /opt/$${TARGET}/bin
        }
        export(target.path)
    }
    INSTALLS += target
}

android {
    message( "My android build..." )
    deployment.path = /assets
    deployment.files += database/RussianCook.sqlite \

    images.path = /assets/images
    images.files = images/*
    content.path =  /assets/content
    content.files = content/*
    INSTALLS += images
    INSTALLS += content


} else {
    message( "My Win build in...")
    message($$OUT_PWD )
    deployment.path = $$OUT_PWD/
    deployment.files += database/RussianCook.sqlite \


}

INSTALLS += deployment

export(INSTALLS)
