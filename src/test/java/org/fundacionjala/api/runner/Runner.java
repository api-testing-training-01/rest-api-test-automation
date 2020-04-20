package org.fundacionjala.api.runner;

import io.cucumber.testng.AbstractTestNGCucumberTests;
import io.cucumber.testng.CucumberOptions;
import org.fundacionjala.api.config.Environment;
import org.testng.annotations.AfterTest;
import org.testng.annotations.BeforeTest;
import org.testng.annotations.DataProvider;

@CucumberOptions(
        plugin = {"pretty"},
        glue = {"org.fundacionjala.api"},
        features = {"src/test/resources/features"}
)
public class Runner extends AbstractTestNGCucumberTests {

    private static final String DATA_PROVIDER_VAR = "dataproviderthreadcount";

    @BeforeTest
    public void beforeAllScenarios() {
        System.setProperty(DATA_PROVIDER_VAR, Environment.getInstance().getThreadCount());
    }

    @AfterTest
    public void afterAllScenarios() {
        // Code executed after features execution.
    }

    @Override
    @DataProvider(parallel = true)
    public Object[][] scenarios() {
        return super.scenarios();
    }
}
