package com.springmvcdemo.service;
import com.springmvcdemo.mapper.UserMapper;
import com.springmvcdemo.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.web.bind.annotation.RequestParam;

@Service

public class UserService implements UserMapper {
    @Autowired
    //@Autowired注解来自动装配userMapper Bean
    private UserMapper userMapper;

    public User findId(int id) {
        return userMapper.findId(id);
    }


    public int deleteById(int id) {
        return userMapper.deleteById(id);
    }


    public int insert(User user) {
        return userMapper.insert(user);
    }


    public int update(User user) {
        return userMapper.update(user);
    }
    public int updateById(int id){
        return userMapper.updateById(id);
    }


    public List<User> getAll() {
        return userMapper.getAll();
    }

}