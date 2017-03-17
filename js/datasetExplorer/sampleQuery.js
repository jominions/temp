function generatePatientSampleCohort(callback)
{
    //Verify subsets are entered.
    if(areAllSubsetsEmpty()) return false;

    //Determine subset count.
    determineNumberOfSubsets();

    //Iterate through all subsets calling the ones that need to be run.
    for (i = 1; i <= GLOBAL.NumOfSubsets; i = i + 1)
    {
        if( ! isSubsetEmpty(i) && GLOBAL.CurrentSubsetIDs[i] == null)
        {
            runQuery(i, callback);
        }
    }

}

//Verify the user actually selected subsets.
function areAllSubsetsEmpty()
{
    if(isSubsetEmpty(1) && isSubsetEmpty(2))
    {
        Ext.Msg.alert('子集为空', '所有子集均为空。请选择子集。');//<SIAT_zh_CN original="Subsets are empty">子集为空</SIAT_zh_CN>//<SIAT_zh_CN original="All subsets are empty. Please select subsets.">所有子集均为空。请选择子集。</SIAT_zh_CN>
       
        return true;
    }
}

//Determine the number of subsets we need and store it in a global js variable.
function determineNumberOfSubsets()
{
    var subsetstorun = 0;

    for (i = 1; i <= GLOBAL.NumOfSubsets; i = i + 1)
    {
        if( ! isSubsetEmpty(i) && GLOBAL.CurrentSubsetIDs[i] == null)
        {
            subsetstorun ++ ;
        }
    }

    STATE.QueryRequestCounter = subsetstorun;
}