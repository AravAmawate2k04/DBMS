order.js
    var productPrices = {};

    $(function () {
        //Json data by api call for order table
        $.get(productListApiUrl, function (response) {
            productPrices = {}
            if(response) {
                var options = '<option value="">--Select--</option>';
                $.each(response, function(index, product) {
                    options += '<option value="'+ product.product_id +'">'+ product.name +'</option>';
                    productPrices[product.product_id] = product.price_per_unit;
                });
                $(".product-box").find("select").empty().html(options);
            }
        });
    });

    $("#addMoreButton").click(function () {
        var row = $(".product-box").html();
        $(".product-box-extra").append(row);
        $(".product-box-extra .remove-row").last().removeClass('hideit');
        $(".product-box-extra .product-price").last().text('0.0');
        $(".product-box-extra .product-qty").last().val('1');
        $(".product-box-extra .product-total").last().text('0.0');
    });

    $(document).on("click", ".remove-row", function (){
        $(this).closest('.row').remove();
        calculateValue();
    });

    $(document).on("change", ".cart-product", function (){
        var product_id = $(this).val();
        var price = productPrices[product_id];

        $(this).closest('.row').find('#product_price').val(price);
        calculateValue();
    });

    $(document).on("change", ".product-qty", function (e){
        calculateValue();
    });
    $(document).ready(function() {
        $("#addMoreProduct").click(function() {
            $("#productRows").append(
                '<div class="row product-row">' +
                '<div class="col-sm-2">' +
                '<label>Product ID</label>' +
                '<input name="productID" type="text" class="form-control" placeholder="Product ID">' +
                '</div>' +
                '<div class="col-sm-2">' +
                '<label>Quantity</label>' +
                '<input name="quantity" type="text" class="form-control" placeholder="Quantity">' +
                '</div>' +
                '<div class="col-sm-2">' +
                '<button type="button" class="btn btn-danger removeProductRow">Remove</button>' +
                '</div>' +
                '</div>'
            );
        });
    
        $(document).on('click', '.removeProductRow', function() {
            $(this).closest('.product-row').remove();
        });
    
        $("#saveOrder").click(function() {
            var orderData = $("#orderForm").serializeArray(); // Collect order details
            var products = [];
        
            // Collect product IDs and quantities
            $(".product-row").each(function() {
                var productID = $(this).find("input[name='productID']").val();
                var quantity = $(this).find("input[name='quantity']").val();
                if (productID && quantity) { // Check if both fields are filled
                    products.push({productID: productID, quantity: quantity});
                }
            });
        
            // Combine order details with product data
            var requestPayload = {
                orderDetails: orderData,
                products: products
            };
        
            // Send data to server for insertion
            callApi("POST", orderSaveApiUrl, {
                'data': JSON.stringify(requestPayload)
            });
        });
        
    });