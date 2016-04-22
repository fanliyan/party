package cn.edu.ccu.model.common;

import java.util.List;

/**
 *  Created by kuangye on 2016/1/8.
 *
 *  用于 jQuery nestable 可拖拽插件
 */
public class NestableModel {

    private Integer id;

    private List<NestableModel> children;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public List<NestableModel> getChildren() {
        return children;
    }

    public void setChildren(List<NestableModel> children) {
        this.children = children;
    }
}
