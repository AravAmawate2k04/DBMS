var productModal = $("#productModal");
$(function () {

    //JSON data by API call
    $.get(productListApiUrl, function (response) {
        if(response) {
            var table = '';
            $.each(response, function(index, product) {
                table += '<tr data-id="'+ product.ProductID +'" data-name="'+ product.ProductName +'" data-description="'+ product.ProductDescription +'" data-unit="'+ product.UnitWeight +'" data-price="'+ product.UnitPrice +'" data-supplier="'+ product.SupplierID +'" data-category="'+ product.CategoryID +'">' +
                    '<td>'+ product.ProductName +'</td>'+
                    '<td>'+ product.ProductDescription +'</td>'+
                    '<td>'+ product.UnitWeight +'</td>'+
                    '<td>'+ product.UnitPrice +'</td>'+
                    '<td>'+ product.SupplierID +'</td>'+
                    '<td>'+ product.CategoryID +'</td>'+
                    '<td><span class="btn btn-xs btn-danger delete-product">Delete</span></td></tr>';
            });
            $("table").find('tbody').empty().html(table);
        }
    });
});

// Save Product
$("#saveProduct").on("click", function () {
    // If we found id value in form then update product detail
    var data = $("#productForm").serializeArray();
    var requestPayload = {
        ProductName: null,
        ProductDescription: null,
        UnitWeight: null,
        UnitPrice: null,
        SupplierID: null,
        CategoryID: null
    };
    for (var i=0;i<data.length;++i) {
        var element = data[i];
        switch(element.name) {
            case 'ProductName':
                requestPayload.ProductName = element.value;
                break;
            case 'ProductDescription':
                requestPayload.ProductDescription = element.value;
                break;
            case 'UnitWeight':
                requestPayload.UnitWeight = element.value;
                break;
            case 'UnitPrice':
                requestPayload.UnitPrice = element.value;
                break;
            case 'SupplierID':
                requestPayload.SupplierID = element.value;
                break;
            case 'CategoryID':
                requestPayload.CategoryID = element.value;
                break;
        }
    }
    callApi("POST", productSaveApiUrl, {
        'data': JSON.stringify(requestPayload)
    });
});

$(document).on("click", ".delete-product", function (){
    var tr = $(this).closest('tr');
    var data = {
        ProductID : tr.data('id')
    };
    var isDelete = confirm("Are you sure to delete "+ tr.data('name') +" item?");
    if (isDelete) {
        callApi("POST", productDeleteApiUrl, data);
    }
});

productModal.on('hide.bs.modal', function(){
    $("#id, #ProductName, #ProductDescription, #UnitWeight, #UnitPrice, #SupplierID, #CategoryID").val('');
    productModal.find('.modal-title').text('Add New Product');
});

productModal.on('show.bs.modal', function(){
    //JSON data by API call
    // $.get(uomListApiUrl, function (response) {
    //     if(response) {
    //         var options = '<option value="">--Select--</option>';
    //         $.each(response, function(index, uom) {
    //             options += '<option value="'+ uom.uom_id +'">'+ uom.uom_name +'</option>';
    //         });
    //         $("#uoms").empty().html(options);
    //     }
    // });
});