package cn.edu.ccu.data.system;


import cn.edu.ccu.data.PartyDB;
import cn.edu.ccu.model.system.SysDictModel;

import java.util.List;

@PartyDB
public interface SysDictModelMapper {

    List<SysDictModel> selectByType(String type);
}