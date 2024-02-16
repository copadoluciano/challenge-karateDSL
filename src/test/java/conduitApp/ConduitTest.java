package conduitApp;
import com.intuit.karate.junit5.Karate;
import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.Test;

class ConduitTest {

    @Karate.Test
    Karate testAll() {
        return Karate.run().relativeTo(getClass());
    }
}

// @Karate.Test
// void testParallel() {
//     Results results = Runner.path("classpath:conduitApp")
//             .tags("~@ignore")
//             //.outputCucumberJson(true)
//             .parallel(5);
//     assertEquals(0, results.getFailCount(), results.getErrorMessages());
// }
