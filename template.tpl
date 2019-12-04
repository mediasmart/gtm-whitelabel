___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "TAG",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "Conversion Tracking",
  "brand": {
    "id": "conversiontrack",
    "displayName": "Conversion Tracking",
    "logo": ""
  },
  "description": "Conversion tracking allows tracking conversions on programmatic campaigns that run on your DSP",
  "categories": [
    "CONVERSIONS",
    "ADVERTISING",
    "ANALYTICS"
  ],
  "containerContexts": [
    "WEB"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "LABEL",
    "name": "reminder",
    "displayName": "For accurate tracking, &msxt=%msxt% (or ?msxt=%msxt%) is needed to be added to the click tracker and made transferrable to the landing page"
  },
  {
    "type": "TEXT",
    "name": "organizationId",
    "displayName": "Organization ID",
    "simpleValueType": true,
    "alwaysInSummary": true,
    "help": "Find your Organization ID inside console under the organizations section , in the \"General\" tab of your organization",
    "valueValidators": [
      {
        "type": "NON_EMPTY"
      },
      {
        "type": "REGEX",
        "errorMessage": "The value is not an Organization ID. \nFind your Organization ID in console under your organization section",
        "args": [
          "[a-z0-9]+"
        ]
      }
    ],
    "valueHint": "Get your id from console"
  },
  {
    "type": "TEXT",
    "name": "eventNumber",
    "displayName": "event Number",
    "simpleValueType": true,
    "alwaysInSummary": true,
    "defaultValue": 1,
    "help": "Conversion number from 1 to 5",
    "valueValidators": [
      {
        "type": "NON_EMPTY"
      },
      {
        "type": "REGEX",
        "args": [
          "[1-5]"
        ],
        "errorMessage": "The value must be a number between 1 and 5"
      }
    ]
  }
]


___WEB_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "get_referrer",
        "versionId": "1"
      },
      "param": [
        {
          "key": "urlParts",
          "value": {
            "type": 1,
            "string": "any"
          }
        },
        {
          "key": "queriesAllowed",
          "value": {
            "type": 1,
            "string": "any"
          }
        }
      ]
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "send_pixel",
        "versionId": "1"
      },
      "param": [
        {
          "key": "urls",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 1,
                "string": "https://3ma79ae7cua.com/"
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "get_url",
        "versionId": "1"
      },
      "param": [
        {
          "key": "urlParts",
          "value": {
            "type": 1,
            "string": "any"
          }
        },
        {
          "key": "queriesAllowed",
          "value": {
            "type": 1,
            "string": "any"
          }
        }
      ]
    },
    "isRequired": true
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

const sendPixel = require('sendPixel');
const encodeUriComponent = require('encodeUriComponent');
const getUrl = require('getUrl');
const getReferrerUrl = require('getReferrerUrl');
// variable capture
let orgId = data.organizationId;
let eventNumber = data.eventNumber;
// casting to string
orgId = '' + orgId;
eventNumber = '' + eventNumber;
// url parameters
let udid;
let eventId;
let msxt;


// Detection of parameters in url

const msParamReader = function(currentUrl, parameterName, valuePrefix) {
	if (!currentUrl) {
		currentUrl = '';
	}
	let indexStart = currentUrl.indexOf('' + parameterName + '=');
	if (indexStart == -1) {
		indexStart = currentUrl.indexOf('' + valuePrefix);
	}
	let result = indexStart != -1 ? currentUrl.substring(indexStart) : '';
	let indexEnd = result.indexOf('&');
	if(indexEnd != -1) {
	  result = result.substring(0, indexEnd);
	}
	result = result.replace('' + parameterName + '=','');
	result = result.replace('' + valuePrefix + ':','');
  return result;
};

if (!msxt)
{
  msxt = msParamReader(getUrl(), 'msxt' ,'msxt');
}

if (!msxt)
{
  msxt = msParamReader(getReferrerUrl(), 'msxt' ,'msxt');
}

if (!udid)
{
	udid = msParamReader(getUrl(), 'udid' ,'msck');
}

if (!udid)
{
	udid = msParamReader(getReferrerUrl(), 'udid' ,'msck');
}

if (!eventId)
{
	eventId = msParamReader(getUrl(), 'eventid' ,'msev');
}

if (!eventId)
{
	eventId = msParamReader(getReferrerUrl(), 'eventid' ,'msev');
}

let url = 'https://3ma79ae7cua.com/m/open?orgid=' + encodeUriComponent(orgId) + '&ms_event_num=' + encodeUriComponent(eventNumber);
if (eventId) {
	url = url + '&id=' + encodeUriComponent(eventId);
}
if (udid) {
	url = url + '&udid=' + encodeUriComponent(udid);
}
if (msxt) {
	url = url + '&msxt=' + encodeUriComponent(msxt);
}
sendPixel(url, data.gtmOnSuccess, data.gtmOnFailure);


___NOTES___

Created on 23/10/2019 12:46:48
