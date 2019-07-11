/* This function makes us subs for NotificationsChannel */
function connectNotificationsChannel() {
    App.cable.subscriptions.create({
        channel: 'NotificationsChannel', channel_id: $("#user_channel").text()
    },
    {
        received: function(data) {
            return $('#notifications').append(this.renderNotification(data)); /* Add data to DOM.*/
        },
        renderNotification: function(data) {
            return "<span>" + data.type + "</span>";
        },
    });
}
