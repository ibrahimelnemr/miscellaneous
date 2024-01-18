# Setting up environment & dependency

`applicationContext.xml`
```xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans-3.0.xsd">
<bean id="helloworld" class ="com.bhawnagunwani.spring.ioc">
    <property name="message" value="Hello World">
</bean>

</beans>

```

`Application.java`
```java
package com.bhawnagunwani.spring.ioc;
import org.springframework.context.ApplicationContext;
public class Application {
    public static void main(String[] args) {
        ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
        HelloWorld obj = (HelloWorld) context.getBean("helloWorld");
        System.out.println(obj);
    }
}
```