package org.transmart

import org.transmart.biomart.BioAssayPlatform
import org.transmart.biomart.BioDataExternalCode
import org.transmart.biomart.ConceptCode
import org.transmart.searchapp.GeneSignature
import org.transmart.searchapp.SearchKeyword
import org.transmart.searchapp.SearchKeywordTerm

/**
 * @author $Author: mmcduffie $
 * $Id: SearchKeywordService.groovy 9178 2011-08-24 13:50:06Z mmcduffie $
 * $Revision: 9178 $
 *
 */
public class SearchKeywordService {

    def springSecurityService

    // probably not needed but makes all methods transactional
    static transactional = true

    //Hard-coded list of items that we consider filter categories... configure in Config/database?
    def filtercats = [

            [codeTypeName: "THERAPEUTIC_DOMAIN", category: "THERAPEUTIC_DOMAIN", displayName: "项目治疗领域(Program Therapeutic Domain)"],//<SIAT_zh_CN original="Program Therapeutic Domain">项目治疗领域(Program Therapeutic Domain)</SIAT_zh_CN>
            [codeTypeName: "PROGRAM_INSTITUTION", category: "PROGRAM_INSTITUTION", displayName: "项目机构"],//<SIAT_zh_CN original="Program Institution">项目机构</SIAT_zh_CN>

            [codeTypeName: "STUDY_PHASE", category: "STUDY_PHASE", displayName: "案例(Study)阶段"],//<SIAT_zh_CN original="Study Phase">案例(Study)阶段</SIAT_zh_CN>
            [codeTypeName: "STUDY_OBJECTIVE", category: "STUDY_OBJECTIVE", displayName: "案例(Study)目标"],//<SIAT_zh_CN original="Study Objective">案例(Study)目标</SIAT_zh_CN>
            [codeTypeName: "STUDY_DESIGN", category: "STUDY_DESIGN", displayName: "案例(Study)设计"],//<SIAT_zh_CN original="Study Design">案例(Study)设计</SIAT_zh_CN>
            [codeTypeName: "STUDY_BIOMARKER_TYPE", category: "STUDY_BIOMARKER_TYPE", displayName: "案例(Study)生物标志物类型"],//<SIAT_zh_CN original="Study Biomarker Type">案例(Study)生物标志物类型</SIAT_zh_CN>
            [codeTypeName: "STUDY_ACCESS_TYPE", category: "STUDY_ACCESS_TYPE", displayName: "案例(Study)访问类型"],//<SIAT_zh_CN original="Study Access Type">案例(Study)访问类型</SIAT_zh_CN>
            [codeTypeName: "STUDY_INSTITUTION", category: "STUDY_INSTITUTION", displayName: "案例(Study)机构"],//<SIAT_zh_CN original="Study Institution">案例(Study)机构</SIAT_zh_CN>

            [codeTypeName: "ASSAY_TYPE_OF_BM_STUDIED", category: "ASSAY_TYPE_OF_BM_STUDIED", displayName: "生物标志物的测定类型"],//<SIAT_zh_CN original="Assay Type of Biomarkers">生物标志物的测定类型</SIAT_zh_CN>
            [category: "ASSAY_MEASUREMENT_TYPE", displayName: "试验测量类型", useText: true, platformProperty: 'platformType'],//<SIAT_zh_CN original="Assay Measurement Type">试验测量类型</SIAT_zh_CN>
            [category: "ASSAY_TECHNOLOGY", displayName: "测定技术", prefix: true, useText: true, platformProperty: 'platformTechnology'],//<SIAT_zh_CN original="Assay Technology">测定技术</SIAT_zh_CN>
            [category: "ASSAY_VENDOR", displayName: "测定供应商", prefix: true, useText: true, platformProperty: 'vendor'],//<SIAT_zh_CN original="Assay Vendor">测定供应商</SIAT_zh_CN>
            [category: "ASSAY_PLATFORM_NAME", displayName: "测定平台名称", useText: true, platformProperty: 'name'],//<SIAT_zh_CN original="Assay Platform Name">测定平台名称</SIAT_zh_CN>

            [category: "ANALYSIS_MEASUREMENT_TYPE", displayName: "分析方法类型", useText: true, platformProperty: 'platformType'],//<SIAT_zh_CN original="Analysis Measurement Type">分析方法类型</SIAT_zh_CN>
            [category: "ANALYSIS_TECHNOLOGY", displayName: "分析技术", prefix: true, useText: true, platformProperty: 'platformTechnology'],//<SIAT_zh_CN original="Analysis Technology">分析技术</SIAT_zh_CN>
            [category: "ANALYSIS_VENDOR", displayName: "分析供应商", prefix: true, useText: true, platformProperty: 'vendor'],//<SIAT_zh_CN original="Analysis Vender">分析供应商</SIAT_zh_CN>
            [category: "ANALYSIS_PLATFORM_NAME", displayName: "分析平台名称", useText: true, platformProperty: 'name'],//<SIAT_zh_CN original="Analysis Platform Name">分析平台名称</SIAT_zh_CN>

            [codeTypeName: "FILE_TYPE", category: "FILE_TYPE", displayName: "文件类型"]//<SIAT_zh_CN original="Bin">文件类型</SIAT_zh_CN>
    ]

    /** Finds all of the search categories pertaining to search keywords */
    def findSearchCategories() {
        log.info "Finding all of the search categories..."

        def c = SearchKeyword.createCriteria()
        def results = c.list {
            projections {
                distinct("dataCategory")
            }
            order("dataCategory", "asc")
        }

        log.info("Categories found: " + results.size())

        def categories = []

        for (result in results) {
            categories.add(["category": result])
        }

        return categories
    }

    def findFilterCategories() {

        def categories = []

        for (filtercat in filtercats) {
            def results

            if (filtercat.platformProperty) {
                results = BioAssayPlatform.createCriteria().list {
                    projections {
                        distinct(filtercat.platformProperty)
                    }
                    order(filtercat.platformProperty, "asc")
                }
            } else if (filtercat.prefix) {
                results = ConceptCode.createCriteria().list {
                    like("codeTypeName", filtercat.codeTypeName + ":%")
                    order("codeName", "asc")
                }
            } else {
                results = ConceptCode.createCriteria().list {
                    eq("codeTypeName", filtercat.codeTypeName)
                    order("codeName", "asc")
                }
            }

            def choices = new TreeSet<Map>(new Comparator() {
                int compare(Object o1, Object o2) {
                    if (!o1 instanceof Map || !o2 instanceof Map) {
                        return 0;
                    }
                    Map m1 = (Map) o1;
                    Map m2 = (Map) o2;
                    return o1.get('name').compareTo(o2.get('name'));
                }
            });
            for (result in results) {
                if (filtercat.platformProperty) {
                    choices.add([name: result, uid: result])
                } else if (filtercat.useText) {
                    choices.add([name: result.codeName, uid: result.codeName])
                } else {
                    choices.add([name: result.codeName, uid: result.bioDataUid.uniqueId[0]])
                }
            }

            if (choices) {
                categories.add(["category": filtercat, "choices": choices])
            }
        }

        return categories
    }

    /** Searches for all keywords for a given term (like %il%) */
    def findSearchKeywords(category, term, max) {
        log.info "Finding matches for ${term} in ${category}"

        def user = springSecurityService.getPrincipal()

        def c = SearchKeywordTerm.createCriteria()
        def results = c.list {
            if (term.size() > 0) {
                like("keywordTerm", term.toUpperCase() + '%')
            }

            if ("GENE_OR_SNP".equals(category)) {
                searchKeyword {
                    or {
                        eq("dataCategory", "GENE")
                        eq("dataCategory", "SNP")
                    }
                }
            } else if ("ALL".compareToIgnoreCase(category) != 0) {
                searchKeyword {
                    eq("dataCategory", category.toUpperCase())
                }
            }

            if (!user.isAdmin()) {
                log.info("User is not an admin so filter out gene lists or signatures that are not public")
                or {
                    isNull("ownerAuthUserId")
                    eq("ownerAuthUserId", user.id)
                }
            }
            maxResults(max)
            order("rank", "asc")
            order("termLength", "asc")
            order("keywordTerm", "asc")
        }
        log.info("Search keywords found: " + results.size())

        def keywords = []
        def dupeList = []            // store category:keyword for a duplicate check until DB is cleaned up

        for (result in results) {
            def m = [:]
            def sk = result
            //////////////////////////////////////////////////////////////////////////////////
            // HACK:  Duplicate check until DB is cleaned up
            def dupeKey = sk.searchKeyword.displayDataCategory + ":" + sk.searchKeyword.keyword +
                    ":" + sk.searchKeyword.bioDataId
            if (dupeKey in dupeList) {
                log.info "Found duplicate: " + dupeKey
                continue
            } else {
                log.info "Found new entry, adding to the list: " + dupeList
                dupeList << dupeKey
            }
            ///////////////////////////////////////////////////////////////////////////////////

            m.put("label", sk.searchKeyword.keyword)
            m.put("category", sk.searchKeyword.displayDataCategory)
            m.put("categoryId", sk.searchKeyword.dataCategory)

            if ("GENE_OR_SNP".equals(category) || ("SNP".equals(category))) {
                m.put("id", sk.searchKeyword.id)
            } else {
                m.put("id", sk.searchKeyword.uniqueId)
            }

            if ("TEXT".compareToIgnoreCase(sk.searchKeyword.dataCategory) != 0) {
                def synonyms = org.transmart.biomart.BioDataExternalCode.findAllWhere(bioDataId: sk.searchKeyword.bioDataId, codeType: "SYNONYM")
                def synList = new StringBuilder()
                for (synonym in synonyms) {
                    if (synList.size() > 0) {
                        synList.append(", ")
                    } else {
                        synList.append("(")
                    }
                    synList.append(synonym.code)
                }
                if (synList.size() > 0) {
                    synList.append(")")
                }
                m.put("synonyms", synList.toString())
            }
            keywords.add(m)
        }

        /*
        * Get results from Bio Concept Code table
        */

        if (category.equals("ALL")) {
            results = ConceptCode.createCriteria().list {
                if (term.size() > 0) {
                    like("bioConceptCode", term.toUpperCase().replace(" ", "_") + '%')
                }
                or {
                    'in'("codeTypeName", filtercats*.codeTypeName)
                }
                maxResults(max)
                order("bioConceptCode", "asc")
            }
            log.info("Bio concept code keywords found: " + results.size())

            for (result in results) {
                def m = [:]

                //Get display name by category
                def cat = filtercats.find { result.codeTypeName.startsWith(it.codeTypeName) }

                m.put("label", result.codeName)
                m.put("category", cat.displayName)
                m.put("categoryId", cat.category)
                if (cat.useText) {
                    m.put("id", result.codeName)
                } else {
                    m.put("id", result.bioDataUid.uniqueId[0])
                }
                if (!keywords.find { it.id.equals(m.id) }) {
                    keywords.add(m)
                }

            }

            //If we're not over the maximum result threshold, query the platform table as well
            if (keywords.size() < max) {

                //Perform a query for each platform field
                for (cat in filtercats) {
                    if (cat.platformProperty) {
                        results = BioAssayPlatform.createCriteria().list {
                            ilike(cat.platformProperty, term + '%')
                            maxResults(max)
                            order(cat.platformProperty, "asc")
                        }
                        log.info("Platform " + cat.platformProperty + " keywords found: " + results.size())

                        for (result in results) {
                            def m = [:]

                            m.put("label", result."${cat.platformProperty}")
                            m.put("category", cat.displayName)
                            m.put("categoryId", cat.category)
                            m.put("id", result."${cat.platformProperty}")

                            if (!keywords.find { it.id.equals(m.id) && it.category.equals(m.category) }) {
                                keywords.add(m)
                            }
                        }
                    }
                }
            }
        }


        return keywords
    }

    /** Searches for all keywords for a given term (like %il%) */
    def findSearchKeywords(category, term) {
        log.info "Finding matches for ${term} in ${category}"

        def user = springSecurityService.getPrincipal()

        def c = SearchKeywordTerm.createCriteria()
        def results = c.list {
            if (term.size() > 0) {
                ilike("keywordTerm", '%' + term + '%')
            }
            if (category.class.name.toLowerCase() == 'java.util.arraylist') {
                searchKeyword {
                    inList("dataCategory", category)
                }
            } else {
                if ("ALL".compareToIgnoreCase(category) != 0) {
                    searchKeyword {
                        eq("dataCategory", category, [ignoreCase: true])
                    }
                }
            }

            if (!user.isAdmin()) {
                log.info("User is not an admin so filter out gene lists or signatures that are not public")
                or {
                    isNull("ownerAuthUserId")
                    eq("ownerAuthUserId", user.id)
                }
            }
            maxResults(20)
            order("rank", "asc")
            order("termLength", "asc")
            order("keywordTerm", "asc")
        }
        log.info("Search keywords found: " + results.size())

        def keywords = []
        def dupeList = []            // store category:keyword for a duplicate check until DB is cleaned up

        for (result in results) {
            def m = [:]
            def sk = result
            //////////////////////////////////////////////////////////////////////////////////
            // HACK:  Duplicate check until DB is cleaned up
            def dupeKey = sk.searchKeyword.displayDataCategory + ":" + sk.searchKeyword.keyword
            if (dupeKey in dupeList) {
                log.info "Found duplicate: " + dupeKey
                continue
            } else {
                log.info "Found new entry, adding to the list: " + dupeList
                dupeList << dupeKey
            }
            ///////////////////////////////////////////////////////////////////////////////////
            m.put("label", sk.searchKeyword.keyword)
            m.put("id", sk.searchKeyword.id)
            m.put("category", sk.searchKeyword.displayDataCategory)
            m.put("categoryId", sk.searchKeyword.dataCategory)
            if ("TEXT".compareToIgnoreCase(sk.searchKeyword.dataCategory) != 0) {
                def synonyms = BioDataExternalCode.findAllWhere(bioDataId: sk.searchKeyword.bioDataId, codeType: "SYNONYM")
                def synList = new StringBuilder()
                for (synonym in synonyms) {
                    if (synList.size() > 0) {
                        synList.append(", ")
                    } else {
                        synList.append("(")
                    }
                    synList.append(synonym.code)
                }
                if (synList.size() > 0) {
                    synList.append(")")
                }
                m.put("synonyms", synList.toString())
            }
            keywords.add(m)
        }
        return keywords
    }
    /**
     * This will render a UI where the user can pick an experiment from a list of all the experiments in the system. Selection of multiple studies is allowed.
     */
    def browseAnalysisMultiSelect = {
        def analyses = org.transmart.biomart.BioAssayAnalysis.executeQuery("select id, name, etlId from BioAssayAnalysis b order by b.name");
        render(template: 'browseMulti', model: [analyses: analyses])
    }

    /**
     * convert pathways to a list of genes
     */
    def expandPathwayToGenes(pathwayIds) {
        return expandPathwayToGenes(pathwayIds, null)
    }

    /**
     * convert pathways to a list of genes
     */
    def expandPathwayToGenes(pathwayIds, Long max) {
        if (pathwayIds == null || pathwayIds.length() == 0) {
            return []
        }
        def query = "select DISTINCT k from org.transmart.searchapp.SearchKeyword k, org.transmart.biomart.BioDataCorrelation c where k.bioDataId=c.associatedBioDataId and c.bioDataId in (" + pathwayIds + ") ORDER BY k.keyword"
        if (max != null)
            return SearchKeyword.executeQuery(query, [max: max])
        else
            return SearchKeyword.executeQuery(query)


    }

    def expandAllListToGenes(pathwayIds) {
        return expandAllListToGenes(pathwayIds, null);
    }

    def expandAllListToGenes(pathwayIds, Long max) {
        if (pathwayIds == null || pathwayIds.length() == 0) {
            return []
        }
        def result = [];
        // find pathways
        def query = "select DISTINCT k from org.transmart.searchapp.SearchKeyword k, org.transmart.biomart.BioDataCorrelation c where k.bioDataId=c.associatedBioDataId and c.bioDataId in (" + pathwayIds + ") ORDER BY k.keyword"
        // find gene sigs
        def query2 = "select DISTINCT k from org.transmart.searchapp.SearchKeyword k, org.transmart.searchapp.SearchBioMarkerCorrelFastMV c where k.bioDataId=c.assocBioMarkerId and c.domainObjectId in (" + pathwayIds + ") ORDER BY k.keyword"
        if (max != null)
            result.addAll(SearchKeyword.executeQuery(query, [max: max]))
        if (result.size() < max) {
            result.addAll(SearchKeyword.executeQuery(query2, [max: (max - result.size())]));
        } else {
            result.addAll(SearchKeyword.executeQuery(query));
            result.addAll(SearchKeyword.executeQuery(query2));
        }
        return result;

    }

    /**
     * link a GeneSignature new instance to search
     */
    def newGeneSignatureLink(GeneSignature gs, boolean bFlush) {
        // link  gs to search
        SearchKeyword keyword = createSearchKeywordFromGeneSig(gs)

        keyword.validate()
        println("keyword validate()")

        if (keyword.hasErrors()) {
            println("WARN: SearchKeyword validation error!")
            keyword.errors.each { println it }
        }
        println("INFO: saving new SearchKeyword!")
        keyword.save(flush: bFlush)
    }

    /**
     * update GeneSignature/List link to search
     */
    def updateGeneSignatureLink(GeneSignature gs, String domainKey, boolean bFlush) {
        // find keyword record
        SearchKeyword keyword = SearchKeyword.findByBioDataIdAndDataCategory(gs.id, domainKey)
        println("INFO: retrieved " + keyword)

        // delete search keywords
        if (gs.deletedFlag || (domainKey == GeneSignature.DOMAIN_KEY_GL && gs.foldChgMetricConceptCode.bioConceptCode != 'NOT_USED') || (domainKey == GeneSignature.DOMAIN_KEY && gs.foldChgMetricConceptCode.bioConceptCode == 'NOT_USED')) {
            if (keyword != null) keyword.delete(flush: bFlush)
        } else {
            // add if does not exist
            if (keyword == null) {
                keyword = createSearchKeywordFromGeneSig(gs, domainKey)
            } else {
                // update keyword
                keyword.keyword = gs.name
                keyword.ownerAuthUserId = gs.publicFlag ? null : gs.createdByAuthUser.id
                keyword.terms.each {
                    println("INFO: " + it)
                    it.keywordTerm = gs.name.toUpperCase()
                    it.ownerAuthUserId = gs.publicFlag ? null : gs.createdByAuthUser.id
                    //println("INFO: setting owner to: "+it.ownerAuthUserId)
                }
            }

            keyword.validate()
            if (keyword.hasErrors()) {
                println("WARN: SearchKeyword validation error!")
                keyword.errors.each { println it }
            }
            println("INFO: trying to save SearchKeyword")
            keyword.save(flush: bFlush)
        }
    }

    /**
     * create a new SearchKeyword for a GeneSignatute
     */
    def createSearchKeywordFromGeneSig(GeneSignature gs, String domainKey) {
        println("INFO: creating SearchKeyword for GS: " + gs.name + "[" + domainKey + "]")

        // display category GS or GL?
        def displayName = (domainKey == GeneSignature.DOMAIN_KEY) ? GeneSignature.DISPLAY_TAG : GeneSignature.DISPLAY_TAG_GL

        SearchKeyword keyword = new SearchKeyword()
        keyword.properties.keyword = gs.name
        keyword.properties.bioDataId = gs.id
        keyword.properties.uniqueId = gs.uniqueId
        keyword.properties.dataCategory = domainKey
        keyword.properties.displayDataCategory = displayName
        keyword.properties.dataSource = "Internal"
        if (!gs.publicFlag) keyword.properties.ownerAuthUserId = gs.createdByAuthUser?.id

        // keyword term
        SearchKeywordTerm term = new SearchKeywordTerm()
        term.properties.keywordTerm = gs.name.toUpperCase()
        term.properties.rank = 1
        term.properties.termLength = gs.name.length()
        if (!gs.publicFlag) term.properties.ownerAuthUserId = gs.createdByAuthUser?.id

        // associate term
        keyword.addToTerms(term)

        //println(keyword)
        //println("properties:\n"+keyword.properties)
        return keyword;
    }

}
