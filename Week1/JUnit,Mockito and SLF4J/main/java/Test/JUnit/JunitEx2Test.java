package Test.JUnit;

import Main.JUnit.JunitEx2;
import org.junit.Before;
import org.junit.After;
import org.junit.Test;
import static org.junit.Assert.assertEquals;

public class JunitEx2Test {
    JunitEx2 calc;
    @Before
    public void setUp() {
        calc = new JunitEx2();
        System.out.println("Setup complete");
    }
    @After
    public void tearDown() {
        System.out.println("Test completed");
    }
    @Test
    public void testAdd() {
        // Arrange
        int a = 2;
        int b = 3;
        // Act
        int result = calc.add(a, b);
        // Assert
        assertEquals(5, result);
    }
    @Test
    public void testSubtract() {
        int a = 10;
        int b = 4;
        int result = calc.subtract(a, b);

        assertEquals(6, result);
    }
}