<#if isWithPackage?exists && isWithPackage==true>package ${packageName}.entity;</#if>


<#--
FreeMarker语法笔记1：
isAutoImport?exist 和 isAutoImport?? 的区别：
-->
<#if isAutoImport?exists && isAutoImport==true>
    <#if isLombok?exists && isLombok==true>import lombok.Data;</#if>
    import java.util.Date;
    import java.util.List;
    import java.io.Serializable;
    import javax.persistence.Column;
    import javax.persistence.Entity;
    import javax.persistence.Id;
    import javax.persistence.Table;
    import javax.persistence.GeneratedValue;
    <#if isSwagger?exists && isSwagger==true>
        import io.swagger.annotations.ApiModel;
        import io.swagger.annotations.ApiModelProperty;</#if>
</#if>
/**
* @description ${classInfo.classComment}
* @author ${authorName}
<#--这里是一个内建变量    .now 是FreeMarker的内建变量里面的当前时间，   ?String   现在就能知道问号都是方法调用了-->
* @date ${.now?string('yyyy-MM-dd')}
*/
@Entity
<#if isLombok?exists && isLombok==true>@Data</#if>
<#if isComment?exists && isComment==true>@Table(name="${classInfo.originTableName}")</#if><#if isSwagger?exists && isSwagger==true>
    @ApiModel("${classInfo.classComment}")</#if>
public class ${classInfo.className} implements Serializable {

private static final long serialVersionUID = 1L;

@Id
@GeneratedValue
<#if classInfo.fieldList?exists && classInfo.fieldList?size gt 0>
    <#list classInfo.fieldList as fieldItem >
        <#if isComment?exists && isComment==true>/**
            * ${fieldItem.fieldComment}
            */</#if>

        <#if isSwagger?exists && isSwagger==true>
            @ApiModelProperty("${fieldItem.fieldComment}")</#if>

    <#--  感觉@Column要靠着isComment变量来控制有待商榷  -->
        <#if isComment?exists && isComment==true>@Column(name="${fieldItem.columnName}")</#if>
        private ${fieldItem.fieldClass} ${fieldItem.fieldName};
    </#list>


<#-- 定义一个无参构造函数 -->
    public ${classInfo.className}() {
    }
</#if>

<#if isLombok?exists && isLombok==false>
    public ${fieldItem.fieldClass} get${fieldItem.fieldName?cap_first}() {
    return ${fieldItem.fieldName};
    }

    public void set${fieldItem.fieldName?cap_first}(${fieldItem.fieldClass} ${fieldItem.fieldName}) {
    this.${fieldItem.fieldName} = ${fieldItem.fieldName};
    }
</#if>
}