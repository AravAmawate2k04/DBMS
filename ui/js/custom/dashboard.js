$(function () {
    //Json data by api call for order table
    $.get(orderListApiUrl, function (response) {
        if(response) {
            // to check if response is there 
            // console.log(response);
            var table = '';
            var totalCost = 0;
            $.each(response, function(index, order) {
                totalCost += parseFloat(order.Quantity);
                table += '<tr>' +
                    '<td>'+ order.OrderDate +'</td>'+
                    '<td>'+ order.Order_ID +'</td>'+
                    '<td>'+ order.CustomerID +'</td>'+
                    '<td>'+ order.Quantity +' Rs</td></tr>';
            });
            table += '<tr><td colspan="3" style="text-align: end"><b>Total</b></td><td><b>'+ totalCost.toFixed(2) +' Rs</b></td></tr>';
            $("table").find('tbody').empty().html(table);
        }
    });
});