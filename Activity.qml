// Pretend Android's activity class but in fact it is just a page of UI

import QtQuick 2.0
import "res.js" as Res

FocusScope {
    id : activity
    focus : true

    property var application : null
    property bool noHistory : false
    property alias background : backgroundDrawable.source

    signal back

    // It is emitted after the activity is started after page transition
    signal started

    function start(component,options) {
        if (!application) {
            console.warn("Can not start activity. 'application' property is not set.");
            return;
        }

        return application.start(component,options);
    }

    function onBackKeyPressed() {
        // Override this function if you don't like this behavior
        if (!state) {
            return false;
        }

        state = "";
        return true;
    }

    Drawable {
        id : backgroundDrawable
        source : Res.Style.Theme.colorBackground
        anchors.fill: parent
        z: -1
    }

    Keys.onReleased: {
        if (event.key === Qt.Key_Back) {
            event.accepted = onBackKeyPressed();
        }
    }
}
