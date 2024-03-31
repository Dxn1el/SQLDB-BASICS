#8

CrEATE PROCEDURE usp_get_holders_full_name()
BEGIN
    SELECT concat(first_name, ' ', last_name) as full_name
    from account_holders
    order by full_name, id;
end;

#9
create procedure usp_get_holders_with_balance_higher_than(money DECIMAL(19, 4))
begin
    select ah.first_name, ah.last_name
    FROM account_holders AS ah
             left join accounts as a on ah.id = a.account_holder_id
    group by ah.first_name, ah.last_name
    HAVING SUM(a.balance) > money
    order by a.account_holder_id;
end;

#10
CREATE FUNCTION ufn_calculate_future_value(sum DECIMAL(19, 4), yearly_rate DOUBLE, years INT)
    returns DECIMAL(19, 4)
    deterministic
begin
    DECLARE future_sum DECIMAL(19, 4);
    SET future_sum := sum * POW(1 + yearly_rate, years);
    return future_sum;

end;

#11
CREATE PROCEDURE usp_calculate_future_value_for_account(id INT, rate DECIMAL(19, 4))
BEGIN
    select a.id,
           ah.first_name,
           ah.last_name,
           balance,
           ufn_calculate_future_value(a.balance, rate, 5)
    from account_holders as ah
             join accounts as a on ah.id = a.account_holder_id;
    WHERE a.id = id;
end;

CREATE PROCEDURE usp_deposit_money(account_id INT, money_amount DECIMAL(19, 4))
begin
    START TRANSACTION ;
    IF (money_amount <= 0) THEN
        ROLLBACK ;
    ELSE
        UPDATE accounts set balance = balance + money_amount;
        where id=account_id;
    end if;
end;

CREATE PROCEDURE usp_withdraw_money(account_id INT, money_amount DECIMAL(19, 4))
BEGIN
    START TRANSACTION ;
    IF (money_amount <= 0 OR (select balance from accounts where id = account_id)) then
        rollback;
    else
        update accounts set balance= balance - money_amount;
    end if;
end;

#14
create procedure usp_transfer_money(from_id INT, to_id INT, sum DECIMAL(19, 4))
BEGIN
    START TRANSACTION;
    # VALID ID
    IF from_id = to_id OR
       sum <= 0 OR
       (SELECT balance from accounts where id = from_id) < sum OR
       (select count(id) from accounts where id = from_id) <> 1 OR
       (select count(id) from accounts where id = to_id) <> 1
    then
        rollback ;
    ELSE
        UPDATE accounts
        set balance = balance - sum
        where id = from_id;
        UPDATE accounts
        set balance = balance + sum
        where id = from_id;
        commit;
    END IF;
end;

#15 LOG ACCOUNTS TRIGGER
CREATE TABLe logs
(
    log_id     int primary key auto_increment,
    account_id int            not null,
    old_sum    decimal(19, 4) not null,
    new_sum    decimal(19, 4) not null
);
CREATE TRIGGER tr_change_balance
    AFTER UPDATE
    ON accounts
    FOR EACH ROW
BEGIN
    INSERT INTO logs (account_id, old_sum, new_sum)
    VALUES (OLD.id, OLD.balance, NEW.balance);
END;

#16 EMAILS TRIGGER
create table notification_emails
(
    id        int not null primary key auto_increment,
    recipient INT NOT NULL,
    subject   TEXT,
    body      TEXT  
);

CREATE TRIGGER tr_email_on_update
    AFTER INSERT
    on logs
    FOR EACH ROW
begin
    INSERT INTO notification_emails (recipient, subject, body)
    values (
            new.account_id,
            concat('Balance change for account: ', account_id),
            concat('ON', now(), 'Your balance was changed from', new.old_sum, ' to ', new.new_sum, '.')
           );

end ;


