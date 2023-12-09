-- Create TE table
CREATE TABLE TE (
  roll NUMBER,
  div VARCHAR2(1),
  name VARCHAR2(50),
  marks NUMBER
);

-- Sample data
INSERT INTO TE VALUES (1, 'A', 'John', 90);
INSERT INTO TE VALUES (2, 'B', 'Alice', 85);
INSERT INTO TE VALUES (3, 'A', 'Bob', 92);
INSERT INTO TE VALUES (4, 'B', 'Charlie', 88);

-- Declare variables
DECLARE
  CURSOR c_students IS
    SELECT roll, div, name, marks FROM TE;
  v_roll NUMBER;
  v_div VARCHAR2(1);
  v_name VARCHAR2(50);
  v_marks NUMBER;
	v_max number;
BEGIN
  -- Open the cursor
  OPEN c_students;

  -- Fetch data from the cursor
  LOOP
    FETCH c_students INTO v_roll, v_div, v_name, v_marks;
    EXIT WHEN c_students%NOTFOUND;
	SELECT MAX(marks) into v_max FROM TE WHERE div = v_div;
    -- Display topper for each division
    IF v_marks = v_max  THEN
      DBMS_OUTPUT.PUT_LINE('Topper in Division ' || v_div || ': ' || v_name || ' - Marks: ' || v_marks);
    END IF;
  END LOOP;

  -- Close the cursor
  CLOSE c_students;
END;
/