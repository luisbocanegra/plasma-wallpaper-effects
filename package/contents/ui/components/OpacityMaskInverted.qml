import QtQuick

ShaderEffect {
    id: rootItem

    /*!
        This property defines the source item that is going to be masked.

        \note It is not supported to let the effect include itself, for
        instance by setting source to the effect's parent.
    */
    property ShaderEffectSource source

    /*!
        This property defines the item that is going to be used as the mask. The
        mask item gets rendered into an intermediate pixel buffer and the alpha
        values from the result are used to determine the source item's pixels
        visibility in the display.
    */
    property ShaderEffectSource maskSource

    anchors.fill: parent
    fragmentShader: Qt.resolvedUrl("../shaders/opacityMaskInverted.frag.qsb")
    onLogChanged: console.error(log)
}
