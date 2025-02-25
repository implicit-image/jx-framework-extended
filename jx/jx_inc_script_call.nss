//::///////////////////////////////////////////////
//:: JX Script Calling Include
//:: jx_inc_script_call
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: jallaix
//:: Created On: Sep 06, 2007
//:://////////////////////////////////////////////
//
// This include file defines specific functions for executing
// scripts in an extended manner :
// * Setting script parameters;
// * Retrieving a script return value;
// * Using a fork system.
//
// 
//
//:://////////////////////////////////////////////

#include "jx_inc_data_func"



//**************************************//
//                                      //
//              Interface               //
//                                      //
//**************************************//

// Structure that holds a list of parameters for a script
struct script_param_list
{
    string sParamList;
};

//========================================== Script Parameter Setting ==========================================//

// Add a new integer parameter to a list of script parameters.
// - paramList List to which the parameter is added
// - iValue Integer parameter to add to the list
// * Returns the list with the new parameter
struct script_param_list JXScriptAddParameterInt(struct script_param_list paramList, int iValue);

// Add a new float parameter to a list of script parameters.
// - paramList List to which the parameter is added
// - fValue Float parameter to add to the list
// * Returns the list with the new parameter
struct script_param_list JXScriptAddParameterFloat(struct script_param_list paramList, float fValue);

// Add a new string parameter to a list of script parameters.
// - paramList List to which the parameter is added
// - sValue String parameter to add to the list
// * Returns the list with the new parameter
struct script_param_list JXScriptAddParameterString(struct script_param_list paramList, string sValue);

// Add a new integer parameter to a list of script parameters.
// - paramList List to which the parameter is added
// - oValue Object parameter to add to the list
// * Returns the list with the new parameter
struct script_param_list JXScriptAddParameterObject(struct script_param_list paramList, object oValue);

// Add a new location parameter to a list of script parameters.
// - paramList List to which the parameter is added
// - ipValue Location parameter to add to the list
// * Returns the list with the new parameter
struct script_param_list JXScriptAddParameterLocation(struct script_param_list paramList, location lValue);

// Add a new item property parameter to a list of script parameters.
// - paramList List to which the parameter is added
// - ipValue Item property parameter to add to the list
// * Returns the list with the new parameter
struct script_param_list JXScriptAddParameterItemProp(struct script_param_list paramList, itemproperty ipValue);


//========================================== Script Parameter Getting ==========================================//

// Get the list of parameters available for the current script.
// This function should generally be called at the beginning of a script, or at the beginning of an operation in a fork script.
// (the parameters are lost when get JXScriptCall() is called again on the same object).
// * Returns the list of available parameters for the current script
struct script_param_list JXScriptGetParameters();

// Get the operation defined in JXScriptCallFork().
// This function must be called at the beginning of a fork script.
// * Returns the operation previously set
int JXScriptGetForkOperation();

// Get the integer parameter at the specified position in the list of script parameters
// - paramList List of script parameters
// - iParamPos Position in the list of the parameter to get
// * Returns an integer parameter
int JXScriptGetParameterInt(struct script_param_list paramList, int iParamPos);

// Get the float parameter at the specified position in the list of script parameters
// - paramList List of script parameters
// - iParamPos Position in the list of the parameter to get
// * Returns a float parameter
float JXScriptGetParameterFloat(struct script_param_list paramList, int iParamPos);

// Get the string parameter at the specified position in the list of script parameters
// - paramList List of script parameters
// - iParamPos Position in the list of the parameter to get
// * Returns a string parameter
string JXScriptGetParameterString(struct script_param_list paramList, int iParamPos);

// Get the object parameter at the specified position in the list of script parameters
// - paramList List of script parameters
// - iParamPos Position in the list of the parameter to get
// * Returns an object parameter
object JXScriptGetParameterObject(struct script_param_list paramList, int iParamPos);

// Get the location parameter at the specified position in the list of script parameters
// - paramList List of script parameters
// - iParamPos Position in the list of the parameter to get
// * Returns a location parameter
location JXScriptGetParameterLocation(struct script_param_list paramList, int iParamPos);

// Get the item property parameter at the specified position in the list of script parameters
// - paramList List of script parameters
// - iParamPos Position in the list of the parameter to get
// * Returns an item property parameter
itemproperty JXScriptGetParameterItemProp(struct script_param_list paramList, int iParamPos);


//========================================== Script Calling ==========================================//

// Execute a script for the specified target, using a list of parameters.
// - sScript Script to execute
// - paramList List of parameters for the script
// - oTarget Object that executes the script
void JXScriptCall(string sScript, struct script_param_list paramList, object oTarget = OBJECT_SELF);

// Execute a script fork (a script that contains a list of operations), using a list of parameters.
// - sForkScript Fork script to execute
// - iOperation Operation in the script to execute
// - paramList List of parameters for the script
// - oTarget Object that executes the script
void JXScriptCallFork(string sForkScript, int iOperation, struct script_param_list paramList, object oTarget = OBJECT_SELF);


//========================================== Script Response Setting ==========================================//

// Set the integer value that a script returns
// - iValue Integer value to return
void JXScriptSetResponseInt(int iValue);

// Set the float value that a script returns
// - fValue Float value to return
void JXScriptSetResponseFloat(float fValue);

// Set the string value that a script returns
// - sValue Integer value to return
void JXScriptSetResponseString(string sValue);

// Set the object value that a script returns
// - oValue Object value to return
void JXScriptSetResponseObject(object oValue);

// Set the location value that a script returns
// - lValue Location value to return
void JXScriptSetResponseLocation(location lValue);

// Set the item property value that a script returns
// - ipValue Integer value to return
void JXScriptSetResponseItemProp(itemproperty ipValue);


//========================================== Script Response Getting ==========================================//

// Get an integer value that a script returns
// - oTarget Object that has executed the script
// * Returns an integer value
int JXScriptGetResponseInt(object oTarget = OBJECT_SELF);

// Get a float value that a script returns
// - oTarget Object that has executed the script
// * Returns a float value
float JXScriptGetResponseFloat(object oTarget = OBJECT_SELF);

// Get a string value that a script returns
// - oTarget Object that has executed the script
// * Returns a string value
string JXScriptGetResponseString(object oTarget = OBJECT_SELF);

// Get an object value that a script returns
// - oTarget Object that has executed the script
// * Returns an object value
object JXScriptGetResponseObject(object oTarget = OBJECT_SELF);

// Get a location value that a script returns
// - oTarget Object that has executed the script
// * Returns a location value
location JXScriptGetResponseLocation(object oTarget = OBJECT_SELF);

// Get an item property value that a script returns
// - oTarget Object that has executed the script
// * Returns an item property value
itemproperty JXScriptGetResponseItemProp(object oTarget = OBJECT_SELF);




















//**************************************//
//                                      //
//            Implementation            //
//                                      //
//**************************************//


// Constant used to set script parameters on an object
const string JX_SCRIPT_PARAMETERS           = "JX_SCRIPT_PARAMETERS";
const string JX_SCRIPT_RETURNED                 = "JX_SCRIPT_RETURNED";
const string JX_SCRIPT_FORKOPERATION        = "JX_SCRIPT_FORKOPERATION";
const string JX_SCRIPT_PARAMSEPARATOR       = "{|}";
const string JX_SCRIPT_PARAMLISTSEPARATOR   = "{||}";


// Add a new integer parameter to a list of script parameters.
// - paramList List to which the parameter is added
// - iValue Integer parameter to add to the list
// * Returns the list with the new parameter
struct script_param_list JXScriptAddParameterInt(struct script_param_list paramList, int iValue)
{
    if (paramList.sParamList != "")
        paramList.sParamList += JX_SCRIPT_PARAMLISTSEPARATOR;
    paramList.sParamList += IntToString(JX_DATATYPE_INTEGER) + JX_SCRIPT_PARAMSEPARATOR + IntToString(iValue);

    return paramList;
}

// Add a new float parameter to a list of script parameters.
// - paramList List to which the parameter is added
// - fValue Float parameter to add to the list
// * Returns the list with the new parameter
struct script_param_list JXScriptAddParameterFloat(struct script_param_list paramList, float fValue)
{
    if (paramList.sParamList != "")
        paramList.sParamList += JX_SCRIPT_PARAMLISTSEPARATOR;
    paramList.sParamList += IntToString(JX_DATATYPE_FLOAT) + JX_SCRIPT_PARAMSEPARATOR + FloatToString(fValue);

    return paramList;
}

// Add a new string parameter to a list of script parameters.
// - paramList List to which the parameter is added
// - sValue String parameter to add to the list
// * Returns the list with the new parameter
struct script_param_list JXScriptAddParameterString(struct script_param_list paramList, string sValue)
{
    if (paramList.sParamList != "")
        paramList.sParamList += JX_SCRIPT_PARAMLISTSEPARATOR;
    paramList.sParamList += IntToString(JX_DATATYPE_STRING) + JX_SCRIPT_PARAMSEPARATOR + sValue;

    return paramList;
}

// Add a new integer parameter to a list of script parameters.
// - paramList List to which the parameter is added
// - oValue Object parameter to add to the list
// * Returns the list with the new parameter
struct script_param_list JXScriptAddParameterObject(struct script_param_list paramList, object oValue)
{
    if (paramList.sParamList != "")
        paramList.sParamList += JX_SCRIPT_PARAMLISTSEPARATOR;
    paramList.sParamList += IntToString(JX_DATATYPE_OBJECT) + JX_SCRIPT_PARAMSEPARATOR + IntToString(ObjectToInt(oValue));

    return paramList;
}

// Add a new location parameter to a list of script parameters.
// - paramList List to which the parameter is added
// - ipValue Location parameter to add to the list
// * Returns the list with the new parameter
struct script_param_list JXScriptAddParameterLocation(struct script_param_list paramList, location lValue)
{
    if (paramList.sParamList != "")
        paramList.sParamList += JX_SCRIPT_PARAMLISTSEPARATOR;
    paramList.sParamList += IntToString(JX_DATATYPE_LOCATION) + JX_SCRIPT_PARAMSEPARATOR + JXLocationToString(lValue);

    return paramList;
}

// Add a new item property parameter to a list of script parameters.
// - paramList List to which the parameter is added
// - ipValue Item property parameter to add to the list
// * Returns the list with the new parameter
struct script_param_list JXScriptAddParameterItemProp(struct script_param_list paramList, itemproperty ipValue)
{
    if (paramList.sParamList != "")
        paramList.sParamList += JX_SCRIPT_PARAMLISTSEPARATOR;
    paramList.sParamList += IntToString(JX_DATATYPE_ITEMPROPERTY) + JX_SCRIPT_PARAMSEPARATOR + JXItemPropertyToString(ipValue);

    return paramList;
}

// Execute a script for the specified target, using a list of parameters.
// - sScript Script to execute
// - paramList List of parameters for the script
// - oTarget Object that executes the script
void JXScriptCall(string sScript, struct script_param_list paramList, object oTarget = OBJECT_SELF)
{
    if (!GetIsObjectValid(oTarget)) return;

    /* SetLocalString(oTarget, JX_SCRIPT_PARAMETERS, paramList.sParamList); */
    AddScriptParameterString(paramList.sParamList);
    ExecuteScriptEnhanced(sScript, oTarget, FALSE);
}

// Execute a script fork (a script that contains a list of operations), using a list of parameters.
// - sForkScript Fork script to execute
// - iOperation Operation in the script to execute
// - paramList List of parameters for the script
// - oTarget Object that executes the script
void JXScriptCallFork(string sForkScript, int iOperation, struct script_param_list paramList, object oTarget = OBJECT_SELF)
{
    if (!GetIsObjectValid(oTarget)) return;

    SetLocalInt(oTarget, JX_SCRIPT_FORKOPERATION, iOperation);
    JXScriptCall(sForkScript, paramList, oTarget);
}

// Get the operation defined in JXScriptCallFork().
// This function must be called at the beginning of a fork script.
// * Returns the operation previously set
int JXScriptGetForkOperation()
{
    int iOperation = GetLocalInt(OBJECT_SELF, JX_SCRIPT_FORKOPERATION);
    DeleteLocalInt(OBJECT_SELF, JX_SCRIPT_FORKOPERATION);

    return iOperation;
}

// Get the list of parameters available for the current script.
// This function should generally be called at the beginning of a script, or at the beginning of an operation in a fork script.
// (the parameters are lost when get JXScriptCall() is called again on the same object).
// * Returns the list of available parameters for the current script
struct script_param_list JXScriptGetParameters()
{
    struct script_param_list paramList;
    paramList.sParamList = GetLocalString(OBJECT_SELF, JX_SCRIPT_PARAMETERS);
    DeleteLocalString(OBJECT_SELF, JX_SCRIPT_PARAMETERS);

    return paramList;
}

// Get the integer parameter at the specified position in the list of script parameters
// - paramList List of script parameters
// - iParamPos Position in the list of the parameter to get
// * Returns an integer parameter
int JXScriptGetParameterInt(struct script_param_list paramList, int iParamPos)
{
    string sParameter = JXStringSplit(paramList.sParamList, JX_SCRIPT_PARAMLISTSEPARATOR, iParamPos - 1);
    string sParamType = JXStringSplit(sParameter, JX_SCRIPT_PARAMSEPARATOR, 0);
    if (StringToInt(sParamType) != JX_DATATYPE_INTEGER)
    {
        SendMessageToPC(GetFirstPC(), "Call to JXScriptGetParameterInt() invalid : Parameter number " +
                                      IntToString(iParamPos) + " in  " + paramList.sParamList + " is not an integer");
        return 0;
    }

    return StringToInt(JXStringSplit(sParameter, JX_SCRIPT_PARAMSEPARATOR, 1));
}

// Get the float parameter at the specified position in the list of script parameters
// - paramList List of script parameters
// - iParamPos Position in the list of the parameter to get
// * Returns a float parameter
float JXScriptGetParameterFloat(struct script_param_list paramList, int iParamPos)
{
    string sParameter = JXStringSplit(paramList.sParamList, JX_SCRIPT_PARAMLISTSEPARATOR, iParamPos - 1);
    string sParamType = JXStringSplit(sParameter, JX_SCRIPT_PARAMSEPARATOR, 0);
    if (StringToInt(sParamType) != JX_DATATYPE_FLOAT)
    {
        SendMessageToPC(GetFirstPC(), "Call to JXScriptGetParameterFloat() invalid : Parameter number " +
                                      IntToString(iParamPos) + " in  " + paramList.sParamList + " is not a float");
        return 0.0;
    }

    return StringToFloat(JXStringSplit(sParameter, JX_SCRIPT_PARAMSEPARATOR, 1));
}

// Get the string parameter at the specified position in the list of script parameters
// - paramList List of script parameters
// - iParamPos Position in the list of the parameter to get
// * Returns a string parameter
string JXScriptGetParameterString(struct script_param_list paramList, int iParamPos)
{
    string sParameter = JXStringSplit(paramList.sParamList, JX_SCRIPT_PARAMLISTSEPARATOR, iParamPos - 1);
    string sParamType = JXStringSplit(sParameter, JX_SCRIPT_PARAMSEPARATOR, 0);
    if (StringToInt(sParamType) != JX_DATATYPE_STRING)
    {
        SendMessageToPC(GetFirstPC(), "Call to JXScriptGetParameterString() invalid : Parameter number " +
                                      IntToString(iParamPos) + " in  " + paramList.sParamList + " is not a string");
        return "";
    }

    return JXStringSplit(sParameter, JX_SCRIPT_PARAMSEPARATOR, 1);
}

// Get the object parameter at the specified position in the list of script parameters
// - paramList List of script parameters
// - iParamPos Position in the list of the parameter to get
// * Returns an object parameter
object JXScriptGetParameterObject(struct script_param_list paramList, int iParamPos)
{
    string sParameter = JXStringSplit(paramList.sParamList, JX_SCRIPT_PARAMLISTSEPARATOR, iParamPos - 1);
    string sParamType = JXStringSplit(sParameter, JX_SCRIPT_PARAMSEPARATOR, 0);
    if (StringToInt(sParamType) != JX_DATATYPE_OBJECT)
    {
        SendMessageToPC(GetFirstPC(), "Call to JXScriptGetParameterObject() invalid : Parameter number " +
                                      IntToString(iParamPos) + " in  " + paramList.sParamList + " is not an object");
        return OBJECT_INVALID;
    }

    return IntToObject(StringToInt(JXStringSplit(sParameter, JX_SCRIPT_PARAMSEPARATOR, 1)));
}

// Get the location parameter at the specified position in the list of script parameters
// - paramList List of script parameters
// - iParamPos Position in the list of the parameter to get
// * Returns a location parameter
location JXScriptGetParameterLocation(struct script_param_list paramList, int iParamPos)
{
    string sParameter = JXStringSplit(paramList.sParamList, JX_SCRIPT_PARAMLISTSEPARATOR, iParamPos - 1);
    string sParamType = JXStringSplit(sParameter, JX_SCRIPT_PARAMSEPARATOR, 0);
    if (StringToInt(sParamType) != JX_DATATYPE_LOCATION)
    {
        SendMessageToPC(GetFirstPC(), "Call to JXScriptGetParameterLocation() invalid : Parameter number " +
                                      IntToString(iParamPos) + " in  " + paramList.sParamList + " is not a location");
        location lInvalid;
        return lInvalid;
    }

    return JXStringToLocation(JXStringSplit(sParameter, JX_SCRIPT_PARAMSEPARATOR, 1));
}

// Get the item property parameter at the specified position in the list of script parameters
// - paramList List of script parameters
// - iParamPos Position in the list of the parameter to get
// * Returns an item property parameter
itemproperty JXScriptGetParameterItemProp(struct script_param_list paramList, int iParamPos)
{
    string sParameter = JXStringSplit(paramList.sParamList, JX_SCRIPT_PARAMLISTSEPARATOR, iParamPos - 1);
    string sParamType = JXStringSplit(sParameter, JX_SCRIPT_PARAMSEPARATOR, 0);
    if (StringToInt(sParamType) != JX_DATATYPE_ITEMPROPERTY)
    {
        SendMessageToPC(GetFirstPC(), "Call to JXScriptGetParameterItemProp() invalid : Parameter number " +
                                      IntToString(iParamPos) + " in  " + paramList.sParamList + " is not an item property");
        itemproperty ipInvalid;
        return ipInvalid;
    }

    return JXStringToItemProperty(JXStringSplit(sParameter, JX_SCRIPT_PARAMSEPARATOR, 1));
}

// Set the integer value that a script returns
// - iValue Integer value to return
void JXScriptSetResponseInt(int iValue)
{
    string sReturnedValue = IntToString(iValue);
    SetLocalString(OBJECT_SELF, JX_SCRIPT_RETURNED, sReturnedValue);
}

// Set the float value that a script returns
// - fValue Float value to return
void JXScriptSetResponseFloat(float fValue)
{
    string sReturnedValue = FloatToString(fValue);
    SetLocalString(OBJECT_SELF, JX_SCRIPT_RETURNED, sReturnedValue);
}

// Set the string value that a script returns
// - sValue Integer value to return
void JXScriptSetResponseString(string sValue)
{
    string sReturnedValue = sValue;
    SetLocalString(OBJECT_SELF, JX_SCRIPT_RETURNED, sReturnedValue);
}

// Set the object value that a script returns
// - oValue Object value to return
void JXScriptSetResponseObject(object oValue)
{
    string sReturnedValue = IntToString(ObjectToInt(oValue));
    SetLocalString(OBJECT_SELF, JX_SCRIPT_RETURNED, sReturnedValue);
}

// Set the location value that a script returns
// - lValue Location value to return
void JXScriptSetResponseLocation(location lValue)
{
    string sReturnedValue = JXLocationToString(lValue);
    SetLocalString(OBJECT_SELF, JX_SCRIPT_RETURNED, sReturnedValue);
}

// Set the item property value that a script returns
// - ipValue Integer value to return
void JXScriptSetResponseItemProp(itemproperty ipValue)
{
    string sReturnedValue = JXItemPropertyToString(ipValue);
    SetLocalString(OBJECT_SELF, JX_SCRIPT_RETURNED, sReturnedValue);
}

// Get an integer value that a script returns
// - oTarget Object that has executed the script
// * Returns an integer value
int JXScriptGetResponseInt(object oTarget = OBJECT_SELF)
{
    string sReturnedValue = GetLocalString(oTarget, JX_SCRIPT_RETURNED);
    DeleteLocalString(oTarget, JX_SCRIPT_RETURNED);

    return StringToInt(sReturnedValue);
}

// Get a float value that a script returns
// - oTarget Object that has executed the script
// * Returns a float value
float JXScriptGetResponseFloat(object oTarget = OBJECT_SELF)
{
    string sReturnedValue = GetLocalString(oTarget, JX_SCRIPT_RETURNED);
    DeleteLocalString(oTarget, JX_SCRIPT_RETURNED);

    return StringToFloat(sReturnedValue);
}

// Get a string value that a script returns
// - oTarget Object that has executed the script
// * Returns a string value
string JXScriptGetResponseString(object oTarget = OBJECT_SELF)
{
    string sReturnedValue = GetLocalString(oTarget, JX_SCRIPT_RETURNED);
    DeleteLocalString(oTarget, JX_SCRIPT_RETURNED);

    return sReturnedValue;
}

// Get an object value that a script returns
// - oTarget Object that has executed the script
// * Returns an object value
object JXScriptGetResponseObject(object oTarget = OBJECT_SELF)
{
    string sReturnedValue = GetLocalString(oTarget, JX_SCRIPT_RETURNED);
    DeleteLocalString(oTarget, JX_SCRIPT_RETURNED);

    return IntToObject(StringToInt(sReturnedValue));
}

// Get a location value that a script returns
// - oTarget Object that has executed the script
// * Returns a location value
location JXScriptGetResponseLocation(object oTarget = OBJECT_SELF)
{
    string sReturnedValue = GetLocalString(oTarget, JX_SCRIPT_RETURNED);
    DeleteLocalString(oTarget, JX_SCRIPT_RETURNED);

    return JXStringToLocation(sReturnedValue);
}

// Get an item property value that a script returns
// - oTarget Object that has executed the script
// * Returns an item property value
itemproperty JXScriptGetResponseItemProp(object oTarget = OBJECT_SELF)
{
    string sReturnedValue = GetLocalString(oTarget, JX_SCRIPT_RETURNED);
    DeleteLocalString(oTarget, JX_SCRIPT_RETURNED);

    return JXStringToItemProperty(sReturnedValue);
}
