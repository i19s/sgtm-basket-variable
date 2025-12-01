___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "i19s sGTM Basket Variable",
  "description": "Converts a Basket to the i19s format (Server-Side)",
  "containerContexts": [
    "SERVER"
  ],
  "brand": {
    "displayName": "i19s sGTM Basket Variable"
  }
}



___TEMPLATE_PARAMETERS___

[
  {
    "type": "TEXT",
    "name": "basket",
    "displayName": "your basket (mandatory)",
    "simpleValueType": true,
    "valueValidators": [
      {
        "type": "NON_EMPTY"
      }
    ]
  },
  {
    "type": "TEXT",
    "name": "position_order_number",
    "displayName": "name of your position_order_number (optional)",
    "simpleValueType": true
  },
  {
    "type": "TEXT",
    "name": "position_uuid",
    "displayName": "name of your position_uuid (optional)",
    "simpleValueType": true
  },
  {
    "type": "TEXT",
    "name": "product_id",
    "displayName": "name of your product_id (recommended)",
    "simpleValueType": true
  },
  {
    "type": "TEXT",
    "name": "name",
    "displayName": "name of your product (recommended)",
    "simpleValueType": true
  },
  {
    "type": "TEXT",
    "name": "stock_keeping_unit",
    "displayName": "name of your stock_keeping_unit (optional)",
    "simpleValueType": true
  },
  {
    "type": "TEXT",
    "name": "brand_name",
    "displayName": "name of your brand_name (optional)",
    "simpleValueType": true
  },
  {
    "type": "TEXT",
    "name": "product_price",
    "displayName": "name of your product_price (mandatory)",
    "simpleValueType": true,
    "valueValidators": [
      {
        "type": "NON_EMPTY"
      }
    ]
  },
  {
    "type": "TEXT",
    "name": "quantity",
    "displayName": "name of your quantity (mandatory)",
    "simpleValueType": true,
    "valueValidators": [
      {
        "type": "NON_EMPTY"
      }
    ]
  },
  {
    "type": "TEXT",
    "name": "tracking_category",
    "displayName": "name of your tracking_category (optional)",
    "simpleValueType": true
  },
  {
    "type": "TEXT",
    "name": "discount_value",
    "displayName": "name of your discount_value (optional)",
    "simpleValueType": true
  },
  {
    "type": "TEXT",
    "name": "shipping_costs",
    "displayName": "name of your shipping_costs (optional)",
    "simpleValueType": true
  },
  {
    "type": "TEXT",
    "name": "tax",
    "displayName": "name of your tax (optional)",
    "simpleValueType": true
  },
  {
    "type": "TEXT",
    "name": "product_category",
    "displayName": "name of your product_category (optional)",
    "simpleValueType": true
  }
]


___SANDBOXED_JS_FOR_SERVER___


    'use strict';

    var json = require('JSON');

    var logToConsole = require('logToConsole');


        function transformProducts(unparsedProducts, brand_name_name, discount_value_name, name_name, position_order_number_name, position_uuid_name, product_category_name, product_id_name, product_price_name, quantity_name, shipping_costs_name, stock_keeping_unit_name, tax_name, tracking_category_name) {
            var parsedProducts = unparsedProducts.map(function (entry, index) {
                var basketEntry = {
                    brand_name: brand_name_name && entry[brand_name_name] ? entry[brand_name_name] : '',
                    discount_value: discount_value_name && entry[discount_value_name] ? entry[discount_value_name] : '',
                    name: name_name && entry[name_name] ? entry[name_name] : '',
                    position_order_number: position_order_number_name && entry[position_order_number_name] ? entry[position_order_number_name] : (index + 1).toString(),
                    position_uuid: position_uuid_name && entry[position_uuid_name] ? entry[position_uuid_name] : '',
                    product_category: product_category_name && entry[product_category_name] ? entry[product_category_name] : '',
                    product_id: product_id_name && entry[product_id_name] ? entry[product_id_name] : '',
                    product_price: product_price_name && entry[product_price_name] ? entry[product_price_name] : '',
                    quantity: quantity_name && entry[quantity_name] ? entry[quantity_name] : '',
                    shipping_costs: shipping_costs_name && entry[shipping_costs_name] ? entry[shipping_costs_name] : '',
                    stock_keeping_unit: stock_keeping_unit_name && entry[stock_keeping_unit_name] ? entry[stock_keeping_unit_name] : '',
                    tax: tax_name && entry[tax_name] ? entry[tax_name] : '',
                    tracking_category: tracking_category_name && entry[tracking_category_name] ? entry[tracking_category_name] : 'default'
                };
                logToConsole('basketEntry ' + json.stringify(basketEntry));
                return basketEntry;
            });
            logToConsole('parsedProducts' + json.stringify(parsedProducts));
            return parsedProducts;
        }
        function getDataValue(variableName) {
            return data[variableName];
        }
        var products = data['basket'];
        if (!products) {
            return [];
        }
        logToConsole('products' + json.stringify(products));
        var transformedProducts = transformProducts(products, getDataValue('brand_name'), getDataValue('discount_value'), getDataValue('name'), getDataValue('position_order_number'), getDataValue('position_uuid'), getDataValue('product_category'), getDataValue('product_id'), getDataValue('product_price'), getDataValue('quantity'), getDataValue('shipping_costs'), getDataValue('stock_keeping_unit'), getDataValue('tax'), getDataValue('tracking_category'));
        logToConsole('transformedProducts ' + transformedProducts);
        return transformedProducts;






___SERVER_PERMISSIONS___

[]


___TESTS___

scenarios: []


___NOTES___




