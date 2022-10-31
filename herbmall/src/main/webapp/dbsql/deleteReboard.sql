--deleteReboard.sql
--exec deleteReboard(8);
create or replace procedure deleteReboard --프로시저 이름 
(
--매개변수
    m_no  number
)
is
--변수선언부
    cnt number;
    v_groupNo   number;
    v_step  number;
begin
--답변이 있는 원본글인 경우에는 레코드를 삭제하지 말고 DelFlag = Y 로 update
select step, groupno into v_step, v_groupNo
from reboard
where no=m_no;

    --원본글인 경우
    if v_step=0 then
        --답변글이 존재하는지 체크
        select count(*) into cnt
        from reboard
        where groupno=v_groupNo;
        
        --답변글이 존재한다면
        if cnt>1 then
            update reboard
            set delflag='Y'
            where no=m_no;
        else --답변글이 없는 경우
            delete from reboard
            where no=m_no;
        end if;
    else  --답변글인 경우
        delete from reboard
        where no=m_no;
    end if;
    
    commit;
EXCEPTION
    WHEN OTHERS THEN
	raise_application_error(-20001, '글 삭제 실패!');
        ROLLBACK;
end;
