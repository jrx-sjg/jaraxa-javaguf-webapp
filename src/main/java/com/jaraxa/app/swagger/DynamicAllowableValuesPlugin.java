package com.jaraxa.app.swagger;

import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;

import com.google.common.base.Optional;
//import com.sommet.absences.management.upload.service.UploadService;

import springfox.documentation.spi.DocumentationType;
import springfox.documentation.spi.service.ParameterBuilderPlugin;
import springfox.documentation.spi.service.contexts.ParameterContext;
import springfox.documentation.swagger.common.SwaggerPluginSupport;

@Component
@Order(SwaggerPluginSupport.SWAGGER_PLUGIN_ORDER + 1000)
public class DynamicAllowableValuesPlugin implements ParameterBuilderPlugin {

//	@Autowired
//	private UploadService importProcessorManager;
	
	@Override
	public boolean supports(DocumentationType documentationType) {
		return true;
	}

	@Override
	public void apply(ParameterContext parameterContext) {
		final Optional<DynamicAllowableValues> dynamicAllowableValues = parameterContext.resolvedMethodParameter().findAnnotation(DynamicAllowableValues.class);
		
        if (dynamicAllowableValues.isPresent()) {
            final String id = dynamicAllowableValues.get().id();
//            if ("importProcessors".equals(id)) {
//            	AllowableValues values = new AllowableListValues(importProcessorManager.getAvailableImportProcessors(), "LIST");
//            	parameterContext.parameterBuilder().allowableValues(values);
//            }
        }
	}

}
