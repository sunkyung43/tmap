/* 
 * Copyright © 2011, 2012 The UNUS. All rights reserved. 
 */

package com.tmap.common;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.codehaus.jackson.JsonEncoding;
import org.codehaus.jackson.JsonGenerator;
import org.codehaus.jackson.map.ObjectMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.util.Assert;
import org.springframework.util.CollectionUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.servlet.view.AbstractView;

/** 
 * 커스텀 JSON 뷰 클래스<br/>
 * @author LSH 
 * @date 2012. 4. 9. 
 */

public class CustomMappingJacksonJsonView extends AbstractView {
	
	/**
	 * Logger
	 */
	private static Logger logger = LoggerFactory.getLogger(CustomMappingJacksonJsonView.class);

    public CustomMappingJacksonJsonView() {
        objectMapper = new ObjectMapper();
        encoding = JsonEncoding.UTF8;
        prefixJson = false;
        setContentType("application/json");
    }

    public void setObjectMapper(ObjectMapper objectMapper) {
        Assert.notNull(objectMapper, "'objectMapper' must not be null");
        this.objectMapper = objectMapper;
    }

    public void setEncoding(JsonEncoding encoding) {
        Assert.notNull(encoding, "'encoding' must not be null");
        this.encoding = encoding;
    }

    public void setPrefixJson(boolean prefixJson) {
        this.prefixJson = prefixJson;
    }

    public void setRenderedAttributes(Set renderedAttributes) {
        this.renderedAttributes = renderedAttributes;
    }

    protected void prepareResponse(HttpServletRequest request, HttpServletResponse response) {
        response.setContentType(getContentType());
        response.setCharacterEncoding(encoding.getJavaName());
    }

    protected void renderMergedOutputModel(Map model, HttpServletRequest request, HttpServletResponse response) throws Exception {
        Object value = filterModel(model);
        JsonGenerator generator = objectMapper.getJsonFactory().createJsonGenerator(response.getOutputStream(), encoding);
        if(prefixJson)
            generator.writeRaw("{} && ");
        objectMapper.writeValue(generator, value);
        
        //로그출력추가함
        logger.debug(objectMapper.writeValueAsString(value));
    }

    protected Object filterModel(Map model) {
        Map result = new HashMap(model.size());
        Set renderedAttributes = CollectionUtils.isEmpty(this.renderedAttributes) ? model.keySet() : this.renderedAttributes;
        for(Iterator iterator = model.entrySet().iterator(); iterator.hasNext();)
        {
            java.util.Map.Entry entry = (java.util.Map.Entry)iterator.next();
            if(!(entry.getValue() instanceof BindingResult) && renderedAttributes.contains(entry.getKey()))
                result.put((String)entry.getKey(), entry.getValue());
        }

        return result;
    }

    public static final String DEFAULT_CONTENT_TYPE = "application/json";
    private ObjectMapper objectMapper;
    private JsonEncoding encoding;
    private boolean prefixJson;
    private Set renderedAttributes;
}
