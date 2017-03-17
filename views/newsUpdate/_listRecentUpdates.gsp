<g:each var="update" in="${updates}" status="iterator">
    数据集 ${update.dataSetName} 中的记录 ${update.rowsAffected} 已进行 ${update.operation}<!--<SIAT_zh_CN original="${update.rowsAffected} records for the ${update.dataSetName} Data Set were ${update.operation}">数据集 ${update.dataSetName} 中的数据列 ${update.rowsAffected} 已进行 ${update.operation}</SIAT_zh_CN>--> <a href="#"
                                                                                                      onClick="alert('clicky')">More information</a> <br/>
</g:each>