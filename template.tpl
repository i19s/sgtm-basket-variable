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

const json = require('JSON');
const logToConsole = require('logToConsole');

// Mapping von Template-Parameter-Namen (lang) zu Output-Namen (kurz)
const FIELD_MAPPING = {
    brand_name: 'brn',
    discount_value: 'dsv',
    name: 'prn',
    position_order_number: 'id',
    position_uuid: 'uuid',
    product_category: 'prc',
    product_id: 'pid',
    product_price: 'pri',
    quantity: 'qty',
    shipping_costs: 'shp',
    stock_keeping_unit: 'sku',
    tax: 'tax',
    tracking_category: 'trc'
};

// Alle Template-Parameter-Namen
const FIELDS = [
    'brand_name', 'discount_value', 'name', 'position_order_number',
    'position_uuid', 'product_category', 'product_id', 'product_price',
    'quantity', 'shipping_costs', 'stock_keeping_unit', 'tax', 'tracking_category'
];

function getDefault(field, index) {
    if (field === 'tracking_category') {
        return 'default';
    }
    if (field === 'position_order_number') {
        return '' + (index + 1);
    }
    return '';
}

function getValue(entry, fieldMapping, defaultValue) {
    if (fieldMapping && entry[fieldMapping]) {
        return entry[fieldMapping];
    }
    return defaultValue;
}

const products = data.basket;
if (!products) {
    return [];
}

logToConsole('products: ' + json.stringify(products));

const transformedProducts = products.map(function(entry, index) {
    const basketEntry = {};

    FIELDS.forEach(function(field) {
        const mapping = data[field];           // z.B. data.product_id = "item_id"
        const shortName = FIELD_MAPPING[field]; // z.B. "pid"
        const defaultVal = getDefault(field, index);
        basketEntry[shortName] = getValue(entry, mapping, defaultVal);
    });

    logToConsole('basketEntry: ' + json.stringify(basketEntry));
    return basketEntry;
});

logToConsole('transformedProducts: ' + json.stringify(transformedProducts));

return transformedProducts;



___SERVER_PERMISSIONS___

[]


___TESTS___

scenarios:
- name: Test empty basket returns empty array
  code: |
    const mockData = {
      basket: null
    };

    let result = runCode(mockData);
    assertThat(result).isEqualTo([]);

- name: Test single product transformation with short output names
  code: |
    const mockData = {
      basket: [
        {
          item_id: 'PROD-123',
          item_name: 'Test Product',
          price: '29.99',
          qty: '2',
          item_brand: 'TestBrand'
        }
      ],
      product_id: 'item_id',
      name: 'item_name',
      product_price: 'price',
      quantity: 'qty',
      brand_name: 'item_brand'
    };

    let result = runCode(mockData);

    assertThat(result.length).isEqualTo(1);
    assertThat(result[0].pid).isEqualTo('PROD-123');
    assertThat(result[0].prn).isEqualTo('Test Product');
    assertThat(result[0].pri).isEqualTo('29.99');
    assertThat(result[0].qty).isEqualTo('2');
    assertThat(result[0].brn).isEqualTo('TestBrand');
    assertThat(result[0].id).isEqualTo('1');

- name: Test multiple products with position id
  code: |
    const mockData = {
      basket: [
        { pid: 'A1', pname: 'Product A' },
        { pid: 'B2', pname: 'Product B' },
        { pid: 'C3', pname: 'Product C' }
      ],
      product_id: 'pid',
      name: 'pname'
    };

    let result = runCode(mockData);

    assertThat(result.length).isEqualTo(3);
    assertThat(result[0].id).isEqualTo('1');
    assertThat(result[1].id).isEqualTo('2');
    assertThat(result[2].id).isEqualTo('3');
    assertThat(result[0].pid).isEqualTo('A1');
    assertThat(result[1].pid).isEqualTo('B2');

- name: Test missing field mapping returns empty string
  code: |
    const mockData = {
      basket: [
        { id: 'TEST-1' }
      ],
      product_id: 'id'
    };

    let result = runCode(mockData);

    assertThat(result[0].pid).isEqualTo('TEST-1');
    assertThat(result[0].prn).isEqualTo('');
    assertThat(result[0].brn).isEqualTo('');
    assertThat(result[0].qty).isEqualTo('');

- name: Test default tracking_category
  code: |
    const mockData = {
      basket: [
        { id: 'TEST-1' }
      ],
      product_id: 'id'
    };

    let result = runCode(mockData);

    assertThat(result[0].trc).isEqualTo('default');

- name: Test custom tracking_category
  code: |
    const mockData = {
      basket: [
        { id: 'TEST-1', cat: 'electronics' }
      ],
      product_id: 'id',
      tracking_category: 'cat'
    };

    let result = runCode(mockData);

    assertThat(result[0].trc).isEqualTo('electronics');

- name: Test all short field names in output
  code: |
    const mockData = {
      basket: [
        {
          myId: '1',
          myUuid: 'abc-123',
          myPid: 'PROD-1',
          myName: 'Widget',
          mySku: 'SKU-001',
          myPrice: '19.99',
          myBrand: 'Acme',
          myQty: '3',
          myDiscount: '2.00',
          myShipping: '5.00',
          myTax: '1.50',
          myCategory: 'gadgets',
          myProdCat: 'electronics'
        }
      ],
      position_order_number: 'myId',
      position_uuid: 'myUuid',
      product_id: 'myPid',
      name: 'myName',
      stock_keeping_unit: 'mySku',
      product_price: 'myPrice',
      brand_name: 'myBrand',
      quantity: 'myQty',
      discount_value: 'myDiscount',
      shipping_costs: 'myShipping',
      tax: 'myTax',
      tracking_category: 'myCategory',
      product_category: 'myProdCat'
    };

    let result = runCode(mockData);

    assertThat(result[0].id).isEqualTo('1');
    assertThat(result[0].uuid).isEqualTo('abc-123');
    assertThat(result[0].pid).isEqualTo('PROD-1');
    assertThat(result[0].prn).isEqualTo('Widget');
    assertThat(result[0].sku).isEqualTo('SKU-001');
    assertThat(result[0].pri).isEqualTo('19.99');
    assertThat(result[0].brn).isEqualTo('Acme');
    assertThat(result[0].qty).isEqualTo('3');
    assertThat(result[0].dsv).isEqualTo('2.00');
    assertThat(result[0].shp).isEqualTo('5.00');
    assertThat(result[0].tax).isEqualTo('1.50');
    assertThat(result[0].trc).isEqualTo('gadgets');
    assertThat(result[0].prc).isEqualTo('electronics');



___NOTES___




