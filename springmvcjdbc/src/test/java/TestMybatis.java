/*import org.junit.runner.RunWith;

import java.util.logging.Logger;
import org.springframework.beans.factory.annotation.Autowired;

import com.springmvcdemo.model.User;
import com.springmvcdemo.service.UserService;
import org.junit.Test;
import java.util.List;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class) // = extends SpringJUnit4ClassRunner
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring.xml","file:src/main/webapp/WEB-INF/spring-mybatis.xml"})
public class TestMybatis {
    private static final Logger logger = Logger.getLogger(String.valueOf(TestMybatis.class));

    @Autowired
    private UserService userService;

    @Test
    public void test1() {
        User user = userService.findById(5);
        logger.info("username:" + user.getUserName() + " , userAge=" + user.getAge());
    }

    @Test
    public void test2() {
        User user = new User();
        user.setId(0);
        user.setUserName("lisi");
        user.setAge("14");
        userService.insert(user);
    }

    @Test
    public void test3() {
        User user = userService.findById(3);
        user.setAge("27");
        userService.update(user);
    }

    @Test
    public void test4() {
        List<User> userList = userService.getAll();
        for (User user : userList) {
            logger.info("username:" + user.getUserName() + " , userAge=" + user.getAge());
        }
    }

    @Test
    public void test5() {
        userService.deleteById(10);
    }
}
*/