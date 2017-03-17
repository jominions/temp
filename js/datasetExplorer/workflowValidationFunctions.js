/*************************************************************************
 * Copyright 2008-2012 Janssen Research & Development, LLC.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 ******************************************************************/

function detectMissingInput(stringToEvaluate, variableBoxName)
{

    if(stringToEvaluate == '')
    {
        Ext.Msg.alert('遗漏的输入', '请拖拽至少一个概念到'+ variableBoxName +'变量盒中。');
        return false;//<SIAT_zh_CN original="Missing input">遗漏的输入</SIAT_zh_CN>//<SIAT_zh_CN original="Please drag at least one concept into the ' + variableBoxName + ' variable box.">请拖拽至少一个概念到'+ variableBoxName +'变量盒中。</SIAT_zh_CN>
    }
    else
    {
        return true;
    }

}

function detectMultipleNodeTypes(listToEvaluate, variableBoxName)
{
    if(listToEvaluate.length > 1)
    {
        Ext.Msg.alert('错误的输入', '你只能拖拽相同类型(连续，分类，高维)的节点放入输入盒中。' + variableBoxName + ' 输入盒现在有多种类型的节点。');
        return false;//<SIAT_zh_CN original="Wrong input">错误的输入</SIAT_zh_CN>//<SIAT_zh_CN original="You may only drag nodes of the same type (Continuous,Categorical,High Dimensional) into the input box. The ' + variableBoxName + ' input box has multiple types.">你只能拖拽相同类型(连续，分类，高维)的节点放入输入盒中。' + variableBoxName + ' 输入盒现在有多种类型的节点。</SIAT_zh_CN>
    }
    else
    {
        return true;
    }
}

function detectSingleCategoricalNode(nodeList, variableBoxValue, variableBoxName)
{
    if((!nodeList[0] || nodeList[0] == "null") && (variableBoxValue != "") && (!variableBoxValue.match(/\|/g)))
    {
        Ext.Msg.alert('错误的输入',variableBoxName + ' 输入框中需要超过一个的分类输入');
        return false;//<SIAT_zh_CN original="Wrong input">错误的输入</SIAT_zh_CN>//<SIAT_zh_CN original="input box must have more than one categorical input to be used.">输入框中需要超过一个的分类输入</SIAT_zh_CN>
    }
    else
    {
        return true;
    }
}

function detectMultipleValueNodes(nodeList, variableBoxValue, variableBoxName)
{
    if((nodeList[0] == 'valueicon' || nodeList[0] == 'hleaficon') && (variableBoxValue.indexOf("|") != -1))
    {
        Ext.Msg.alert('错误的输入', '对于连续及高维数据，您应只拖拽一个节点到输入框中。' + variableBoxName + '输入框有多个节点。');
        return false;//<SIAT_zh_CN original="Wrong input">错误的输入</SIAT_zh_CN>//<SIAT_zh_CN original="Search">搜索解析器</SIAT_zh_CN>
    }//<SIAT_zh_CN original="For continuous and high dimensional data, you may only drag one node into the input boxes. The ' + variableBoxName + ' input box has multiple nodes.">对于连续及高维数据，您应只拖拽一个节点到输入框中。' + variableBoxName + '输入框有多个节点。</SIAT_zh_CN>
    else
    {
        return true;
    }
}

function detectCatBinningWithoutManual(globalBinningFlag, binningTypeInputName, manualBinningCheckboxName, enableBinningInput, variableBoxName)
{
    if(globalBinningFlag && Ext.get(binningTypeInputName).getValue() != 'Continuous' && !document.getElementById(manualBinningCheckboxName).checked && document.getElementById(enableBinningInput).checked)
    {
        Ext.Msg.alert('错误的输入', '当绑定一个分类变量时，您必须启用手动绑定。(' + variableBoxName + ' 变量)');
        return false;//<SIAT_zh_CN original="Wrong input">错误的输入</SIAT_zh_CN>//<SIAT_zh_CN original="You must enable manual binning when binning a categorical variable. (' + variableBoxName + ' Variable)'">当绑定一个分类变量时，您必须启用手动绑定。(' + variableBoxName + ' 变量)</SIAT_zh_CN>
    }
    else
    {
        return true;
    }

}

function detectCatBinnedAsCont(globalBinningFlag, enableBinningInput, binningTypeInputName, stringToEvaluate, listToEvaluate, snpTypeWindow, markerTypeWindow, variableBoxName)
{
    if(globalBinningFlag && document.getElementById(enableBinningInput).checked && Ext.get(binningTypeInputName).getValue() == 'Continuous' && ((stringToEvaluate != "" && (!listToEvaluate[0] || listToEvaluate[0] == "null")) || (listToEvaluate[0] == 'hleaficon' && window[snpTypeWindow] == "Genotype" && window[markerTypeWindow] == 'SNP')) )
    {
        Ext.Msg.alert('错误的输入', '在' + variableBoxName +'中有一个分类输入，但是您却尝试将其按照连续变量进行分级。请修改您在' + variableBoxName + ' 中的分级选项或概念。');
        return false;//<SIAT_zh_CN original="Wrong input">错误的输入</SIAT_zh_CN>//<SIAT_zh_CN original="There is a categorical input in the ' + variableBoxName + ' variable box, but you are trying to bin it as if it was continuous. Please alter your binning options or the concept in the ' + variableBoxName + ' variable box.">在' + variableBoxName +'中有一个分类输入，但是您却尝试将其按照连续变量进行分级。请修改您在' + variableBoxName + ' 中的分级选项或概念。</SIAT_zh_CN>
    }
    else
    {
        return true;
    }

}

function detectMultipleCategoricalNodesWithoutBinning(nodeList, variableBoxValue, variableBoxName, inputMax, binningEnabled)
{
    if((!nodeList[0] || nodeList[0] == "null") && (variableBoxValue.match(/\|/g)) && (variableBoxValue.match(/\|/g).length + 1 > inputMax) && (!binningEnabled))
    {
        Ext.Msg.alert('错误的输入', variableBoxName + ' 输入框中指定了过多的分类输入。您应仅使用 ' + inputMax + '.');
        return false;//<SIAT_zh_CN original="Wrong input">错误的输入</SIAT_zh_CN>//<SIAT_zh_CN original="The ' + variableBoxName + ' input box has too many categorical inputs specified, you may only use ' + inputMax + '.">variableBoxName + ' 输入框中指定了过多的分类输入。您应仅使用 ' + inputMax + '.'</SIAT_zh_CN>
    }
    else
    {
        return true;
    }
}

function detectMultipleCategoricalNodesWithoutBinningAndGroupCheckboxChecked(nodeList, variableBoxValue, variableBoxName, inputMax, binningEnabled, checkboxValue)
{
    if((!nodeList[0] || nodeList[0] == "null") && (variableBoxValue.match(/\|/g)) && (variableBoxValue.match(/\|/g).length + 1 >= inputMax) && (!binningEnabled) && (checkboxValue))
    {
        Ext.Msg.alert('错误的输入', '当使用分组复选框时，您只能在' + variableBoxName + '变量中提供一个分类变量。 请启用分级选项或从该输入框中移除变量。');
        return false;//<SIAT_zh_CN original="Wrong input">错误的输入</SIAT_zh_CN>//<SIAT_zh_CN original="When using the grouping checkbox you may only supply one categorical variable to the ' + variableBoxName + ' variable. Please enable binning or remove variables from this box.">当使用分组复选框时，您只能在' + variableBoxName + '变量中提供一个分类变量。 请启用分级选项或从该输入框中移除变量。</SIAT_zh_CN>
    }
    else
    {
        return true;
    }
}

function detectMultipleBinsWithGroupCheckboxChecked(binning, numberOfBins, checkboxValue)
{
    if(binning && numberOfBins > 1 && checkboxValue)
    {
        Ext.Msg.alert('错误的输入', '当使用分组复选框时，您只能为依赖变量提供一个桶。');
        return false;//<SIAT_zh_CN original="Wrong input">错误的输入</SIAT_zh_CN>//<SIAT_zh_CN original="When using the grouping checkbox you may only supply one bin for the dependent variable.">当使用分组复选框时，您只能为依赖变量提供一个桶。</SIAT_zh_CN>
    }
    else
    {
        return true;
    }
}

function detectOneBinGroupCheckBoxUnchecked(binning, numberOfBins, checkboxValue)
{
    if(binning && numberOfBins == 1 && !checkboxValue)
    {
        Ext.Msg.alert('错误的输入', '当使用分级时，您必须指定两个桶，或者启用分组复选框。');
        return false;//<SIAT_zh_CN original="Wrong input">错误的输入</SIAT_zh_CN>//<SIAT_zh_CN original="When using binning you must either specify two bins or enable the grouping checkbox.">当使用分级时，您必须指定两个桶，或者启用分组复选框。</SIAT_zh_CN>
    }
    else
    {
        return true;
    }
}


function detectOneBinGroup(binning, numberOfBins, variableBoxName)
{
    if(binning && numberOfBins < 2)
    {
        Ext.Msg.alert('错误的输入', '对于' + variableBoxName + '输入框，您无法指定小于2个桶。');
        return false;//<SIAT_zh_CN original="Wrong input">错误的输入</SIAT_zh_CN>//<SIAT_zh_CN original="You cannot specify less than 2 bins for the ' + variableBoxName + ' input box.">对于' + variableBoxName + '输入框，您无法指定小于2个桶。</SIAT_zh_CN>
    }
    else
    {
        return true;
    }
}




