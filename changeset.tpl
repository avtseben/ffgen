    <changeSet author="{{ffAuthor}}" id="insert_FF_{{ffNumber}}">
        <preConditions onFail="MARK_RAN">
            <sqlCheck expectedResult="0">
                select count(*) from FF4J_FEATURES where FEAT_UID =
                '{{ffName}}'
            </sqlCheck>
        </preConditions>
        <insert tableName="FF4J_FEATURES">
            <column name="FEAT_UID" value="{{ffName}}"/>
            <column name="ENABLE" value="0"/>
            <column name="DESCRIPTION"
                    value="{{ffDescription}}"/>
            <column name="GROUPNAME" value="Sprint {{ffSprintNumber}}"/>
        </insert>
    </changeSet>

    <changeSet author="{{ffAuthor}}" id="update_FF_{{ffNumber}}">
        <preConditions onFail="MARK_RAN">
            <not>
                <sqlCheck expectedResult="0">
                    select count(*) from FF4J_FEATURES where FEAT_UID =
                    '{{ffName}}'
                </sqlCheck>
            </not>
        </preConditions>
        <update tableName="FF4J_FEATURES">
            <column name="ENABLE" value="0"/>
            <column name="DESCRIPTION"
                    value="{{ffDescription}}"/>
            <column name="STRATEGY" value="null"/>
            <column name="EXPRESSION" value="null"/>
            <column name="GROUPNAME" value="Sprint {{ffSprintNumber}}"/>
            <where>FEAT_UID='{{ffName}}'</where>
        </update>
    </changeSet>

    <changeSet author="{{ffAuthor}}" id="insert_FF_type_{{ffNumber}}">
        <preConditions onFail="MARK_RAN">
            <sqlCheck expectedResult="0">
                select count(*) from FF4J_CUSTOM_PROPERTIES where FEAT_UID =
                '{{ffName}}' and
                PROPERTY_ID = 'type'
            </sqlCheck>
        </preConditions>
        <insert tableName="FF4J_CUSTOM_PROPERTIES">
            <column name="PROPERTY_ID" value="type"/>
            <column name="CLAZZ" value="org.ff4j.property.PropertyString"/>
            <column name="CURRENTVALUE" value="{{ffType}}"/>
            <column name="DESCRIPTION" value=""/>
            <column name="FEAT_UID" value="{{ffName}}"/>
        </insert>
    </changeSet>

    <changeSet author="{{ffAuthor}}" id="insert_FF_tag_{{ffNumber}}">
        <preConditions onFail="MARK_RAN">
            <sqlCheck expectedResult="0">
                select count(*) from FF4J_CUSTOM_PROPERTIES where FEAT_UID =
                '{{ffName}}' and
                PROPERTY_ID = 'tag'
            </sqlCheck>
        </preConditions>
        <insert tableName="FF4J_CUSTOM_PROPERTIES">
            <column name="PROPERTY_ID" value="tag"/>
            <column name="CLAZZ" value="org.ff4j.property.PropertyString"/>
            <column name="CURRENTVALUE" value="{{ffTag}}"/>
            <column name="DESCRIPTION" value=""/>
            <column name="FEAT_UID" value="{{ffName}}"/>
        </insert>
    </changeSet>