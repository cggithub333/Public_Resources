create table disease
(
    dose_quantity              int                  null,
    is_active                  tinyint(1) default 1 null,
    is_injected_in_vaccination tinyint(1) default 1 not null,
    disease_id                 bigint auto_increment
        primary key,
    description                text                 null,
    name                       varchar(255)         not null
);

create table equipment
(
    is_active    tinyint(1) default 1 not null,
    equipment_id bigint auto_increment
        primary key,
    unit         varchar(20)          null,
    name         varchar(100)         not null,
    description  text                 null
);

create table grade
(
    grade_id    bigint auto_increment
        primary key,
    grade_level enum ('GRADE_1', 'GRADE_2', 'GRADE_3', 'GRADE_4', 'GRADE_5') not null
);

create table health_check_campaign
(
    created_at             date                                                                   not null,
    deadline_date          date                                                                   not null,
    is_active              tinyint(1) default 1                                                   not null,
    campaign_id            bigint auto_increment
        primary key,
    end_examination_date   datetime(6)                                                            not null,
    start_examination_date datetime(6)                                                            not null,
    title                  varchar(100)                                                           not null,
    address                varchar(255)                                                           not null,
    description            text                                                                   null,
    status_health_campaign enum ('CANCELLED', 'COMPLETED', 'IN_PROGRESS', 'PENDING', 'PUBLISHED') not null
);

create table health_check_disease
(
    disease_id               bigint null,
    health_check_campaign_id bigint null,
    health_check_disease_id  bigint auto_increment
        primary key,
    constraint FK9u3g23chlw41xckyg05ji22rn
        foreign key (health_check_campaign_id) references health_check_campaign (campaign_id),
    constraint FKlp3gl92nxnu2xfgrwguhaed5l
        foreign key (disease_id) references disease (disease_id)
);

create table medication
(
    is_active     tinyint(1) default 1 not null,
    medication_id bigint auto_increment
        primary key,
    unit          varchar(20)          null,
    dosage        varchar(50)          null,
    name          varchar(100)         not null,
    description   text                 null
);

create table pupil
(
    birth_date          date                 not null,
    gender              char                 not null,
    is_active           tinyint(1) default 1 not null,
    parent_phone_number varchar(15)          null,
    first_name          varchar(50)          not null,
    last_name           varchar(50)          not null,
    avatar              varchar(255)         null,
    pupil_id            varchar(255)         not null
        primary key
);

create table health_check_consent_form
(
    is_active       tinyint default 0 not null,
    school_year     int               not null,
    campaign_id     bigint            not null,
    consent_form_id bigint auto_increment
        primary key,
    pupil_id        varchar(255)      not null,
    constraint FK1gw8tu0d4nccrrngu7kyw9ovi
        foreign key (pupil_id) references pupil (pupil_id),
    constraint FKi35mhacjyv18yfcrbcbw70r3w
        foreign key (campaign_id) references health_check_campaign (campaign_id)
);

create table consent_disease
(
    consent_form_id bigint not null,
    disease_id      bigint not null,
    note            text   null,
    primary key (consent_form_id, disease_id),
    constraint FKifa0rk1keehn4ewcm9t7ym7as
        foreign key (consent_form_id) references health_check_consent_form (consent_form_id),
    constraint FKl70bbtajv05kk27wplryvkrt3
        foreign key (disease_id) references disease (disease_id)
);

create table health_check_history
(
    created_at               date                 not null,
    heart_rate               int                  null,
    height                   decimal(5, 2)        null,
    is_active                tinyint(1) default 1 null,
    weight                   decimal(5, 2)        null,
    consent_id               bigint               null,
    health_check_history_id  bigint auto_increment
        primary key,
    blood_pressure           varchar(20)          null,
    left_eye_vision          varchar(20)          null,
    right_eye_vision         varchar(20)          null,
    dental_check             varchar(100)         null,
    digestive_system         varchar(100)         null,
    ear_condition            varchar(100)         null,
    hear_anuscultaion        varchar(100)         null,
    lungs                    varchar(100)         null,
    musculoskeletal_system   varchar(100)         null,
    neurology_and_psychiatry varchar(100)         null,
    nose_condition           varchar(100)         null,
    skin_and_mucosa          varchar(100)         null,
    throat_condition         varchar(100)         null,
    urinary_system           varchar(100)         null,
    additional_notes         varchar(255)         null,
    unusual_signs            varchar(255)         null,
    constraint UK1qcoljs8dsjr13i053oq64cg9
        unique (consent_id),
    constraint FK1jyp0gv4egpxg3fm17c2d6nki
        foreign key (consent_id) references health_check_consent_form (consent_form_id)
);

create table health_condition_history
(
    is_active            tinyint(1) default 1                not null,
    condition_history_id bigint auto_increment
        primary key,
    image_url            varchar(255)                        null,
    name                 varchar(255)                        not null,
    pupil_id             varchar(255)                        not null,
    reaction_or_note     text                                null,
    type_history         enum ('ALLERGY', 'MEDICAL_HISTORY') not null,
    constraint FKfo2qujwftf5x1cdj11qhcxwe2
        foreign key (pupil_id) references pupil (pupil_id)
);

create table pupil_grade
(
    start_year int          not null,
    grade_id   bigint       not null,
    grade_name varchar(50)  not null,
    pupil_id   varchar(255) not null,
    primary key (grade_id, pupil_id),
    constraint FKkr9jjjcsgix8ggjlrbc1wumys
        foreign key (grade_id) references grade (grade_id),
    constraint FKns0uf8vq2plefr1c2f5md1p9d
        foreign key (pupil_id) references pupil (pupil_id)
);

create table send_medication
(
    confirmed_date     date                                                                 null,
    end_date           date                                                                 not null,
    is_active          tinyint(1) default 1                                                 not null,
    start_date         date                                                                 not null,
    requested_date     datetime(6)                                                          not null,
    send_medication_id bigint auto_increment
        primary key,
    disease_name       varchar(100)                                                         not null,
    sender_name        varchar(100)                                                         not null,
    note               text                                                                 null,
    prescription_image varchar(255)                                                         null,
    pupil_id           varchar(255)                                                         not null,
    status             enum ('APPROVED', 'COMPLETED', 'IN_PROGRESS', 'PENDING', 'REJECTED') null,
    constraint FKj4ysx9qkbaodvjhqdd395itq5
        foreign key (pupil_id) references pupil (pupil_id)
);

create table medication_item
(
    medication_id       bigint auto_increment
        primary key,
    send_medication_id  bigint       not null,
    medication_name     varchar(255) not null,
    medication_schedule varchar(255) not null,
    unit_and_usage      text         not null,
    constraint FK6h6jnqvl9i41dsa5ni3uwk2oa
        foreign key (send_medication_id) references send_medication (send_medication_id)
);

create table medication_logs
(
    given_time         datetime(6)                not null,
    log_id             bigint auto_increment
        primary key,
    send_medication_id bigint                     not null,
    note               text                       null,
    status             enum ('GIVEN', 'NOTGIVEN') null,
    constraint FKgvqyek1rouckmlfrljfwdcvox
        foreign key (send_medication_id) references send_medication (send_medication_id)
);

create table user
(
    birth_date   date                                                not null,
    created_at   date                                                not null,
    is_active    tinyint(1) default 1                                not null,
    updated_at   date                                                null,
    phone_number varchar(12)                                         not null,
    first_name   varchar(50)                                         not null,
    last_name    varchar(50)                                         not null,
    password     varchar(72)                                         not null,
    avatar       varchar(255)                                        null,
    device_token varchar(255)                                        null,
    email        varchar(255)                                        null,
    user_id      varchar(255)                                        not null
        primary key,
    role         enum ('ADMIN', 'MANAGER', 'PARENT', 'SCHOOL_NURSE') null
);

create table blog
(
    created_at      date                 not null,
    is_active       tinyint(1) default 1 not null,
    last_updated_at date                 not null,
    blog_id         bigint auto_increment
        primary key,
    status          varchar(20)          not null,
    author_id       varchar(255)         not null,
    content         text                 not null,
    image_url       varchar(255)         null,
    title           varchar(255)         not null,
    verifier_id     varchar(255)         not null,
    constraint FK66b373n8jxc98hu7m3hrq4olt
        foreign key (verifier_id) references user (user_id),
    constraint FKkrg0cqj6o7b7lvqkn1gjuwjuo
        foreign key (author_id) references user (user_id)
);

create table medical_event
(
    is_active             tinyint(1) default 1           not null,
    date_time             datetime(6)                    not null,
    medical_event_id      bigint auto_increment
        primary key,
    detailed_information  text                           null,
    injury_description    text                           null,
    pupil_id              varchar(255)                   not null,
    school_nurse_id       varchar(255)                   not null,
    treatment_description text                           null,
    status                enum ('HIGH', 'LOW', 'MEDIUM') null,
    constraint FK3sr7wsp913mvavevddinw218t
        foreign key (pupil_id) references pupil (pupil_id),
    constraint FKnvh1pp7bsi3afnp7ftaeutsus
        foreign key (school_nurse_id) references user (user_id)
);

create table medical_event_equipment_mapping
(
    equipment_id     bigint not null,
    medical_event_id bigint not null,
    constraint FK229jrvdqphb5geete9qhxhich
        foreign key (equipment_id) references equipment (equipment_id),
    constraint FKr3o39tag0o2au3h383t2sgw3k
        foreign key (medical_event_id) references medical_event (medical_event_id)
);

create table medical_event_medication_mapping
(
    medical_event_id bigint not null,
    medication_id    bigint not null,
    constraint FKhpldapshktwt1an98tw9qpmi6
        foreign key (medical_event_id) references medical_event (medical_event_id),
    constraint FKt7n2e19pb6p5gxjr27xtgwr1k
        foreign key (medication_id) references medication (medication_id)
);

create table pupil_parent
(
    parent_id varchar(255) not null,
    pupil_id  varchar(255) not null,
    constraint UKd37ydfg65u2badd47stjhc2fi
        unique (pupil_id, parent_id),
    constraint FKbkgnouyfuqcet9wocbhu6alkt
        foreign key (parent_id) references user (user_id),
    constraint FKh1cpctfhgh894vam0qeh9iitv
        foreign key (pupil_id) references pupil (pupil_id)
);

create table user_notification
(
    created_at        date                                                                                not null,
    is_read           tinyint(1) default 0                                                                not null,
    notification_id   bigint auto_increment
        primary key,
    source_id         bigint                                                                              not null,
    message           text                                                                                null,
    user_id           varchar(255)                                                                        not null,
    type_notification enum ('HEALTH_CHECK_CAMPAIGN', 'MED_EVENT', 'SEND_MEDICAL', 'VACCINATION_CAMPAIGN') not null,
    constraint FKnbuq84cli119n9cdakdw0kv5v
        foreign key (user_id) references user (user_id)
);

create table vaccine
(
    dose_number     int                  null,
    is_active       tinyint(1) default 1 null,
    vaccine_id      bigint auto_increment
        primary key,
    recommended_age varchar(100)         null,
    description     text                 null,
    manufacturer    varchar(255)         null,
    name            varchar(255)         not null
);

create table disease_vaccine
(
    disease_id bigint not null,
    vaccine_id bigint not null,
    constraint FKdgbcqh8ivdrf62vykpjxenf4s
        foreign key (vaccine_id) references vaccine (vaccine_id),
    constraint FKp3iibixqa3gawtix9vagtl656
        foreign key (disease_id) references disease (disease_id)
);

create table vaccination_campaign
(
    end_date       date                                                                  null,
    form_deadline  date                                                                  null,
    is_active      tinyint(1) default 1                                                  null,
    start_date     date                                                                  null,
    campaign_id    bigint auto_increment
        primary key,
    disease_id     bigint                                                                not null,
    vaccine_id     bigint                                                                not null,
    notes          text                                                                  null,
    title_campaign varchar(255)                                                          not null,
    status         enum ('CANCELED', 'COMPLETED', 'IN_PROGRESS', 'PENDING', 'PUBLISHED') null,
    constraint FK7eio72t0kc9ef4so04pf037gx
        foreign key (vaccine_id) references vaccine (vaccine_id),
    constraint FKl17fjla7lds3yt4hg6yp83jxn
        foreign key (disease_id) references disease (disease_id)
);

create table vaccination_consent_form
(
    is_active       tinyint(1) default 1                                            null,
    campaign_id     bigint                                                          not null,
    consent_form_id bigint auto_increment
        primary key,
    responded_at    datetime(6)                                                     null,
    vaccine_id      bigint                                                          not null,
    pupil_id        varchar(255)                                                    not null,
    status          enum ('APPROVED', 'INJECTED', 'NO_SHOW', 'REJECTED', 'WAITING') null,
    constraint FK70064cpcq34td28n0kmbs8wf5
        foreign key (pupil_id) references pupil (pupil_id),
    constraint FKba7opmhfoxvux3tmb1ldscn8b
        foreign key (vaccine_id) references vaccine (vaccine_id),
    constraint FKogpilaulivhn4ne79pwkus94
        foreign key (campaign_id) references vaccination_campaign (campaign_id)
);

create table vaccination_history
(
    is_active     tinyint(1) default 1                    null,
    campaign_id   bigint                                  null,
    disease_id    bigint                                  not null,
    history_id    bigint auto_increment
        primary key,
    vaccinated_at datetime(6)                             null,
    vaccine_id    bigint                                  not null,
    notes         text                                    null,
    pupil_id      varchar(255)                            not null,
    source        enum ('CAMPAIGN', 'PARENT_DECLARATION') null,
    constraint FKapiylv7t7f6sxfnboqgkx6pin
        foreign key (pupil_id) references pupil (pupil_id),
    constraint FKbaky8t5lmjy6v0uxt1m90j964
        foreign key (vaccine_id) references vaccine (vaccine_id),
    constraint FKoq0526fb1mur3nxl4i3bs6lj5
        foreign key (campaign_id) references vaccination_campaign (campaign_id),
    constraint FKt1x0q7mvxntsfln1hwc3q630w
        foreign key (disease_id) references disease (disease_id)
);

