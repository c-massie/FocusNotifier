workspace.windowActivated.connect(function(client) {

    var output = `
        §pid: ${client.pid}
        §wname: ${client.resourceName}
        §wclass: ${client.resourceClass}
        §wcaption: ${client.caption}
        §end
    `;

    callDBus("scot.massie.FocusNotifier",
            "/scot/massie/FocusNotifier",
            "scot.massie.FocusNotifier",
            "notifyOfFocus",
            output);
})
