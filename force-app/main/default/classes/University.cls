public class University {
    public String universityName;
    public String viceChancellor;
    public Integer studentCount;
    public Integer employeeCount;
    public Integer facultyCount;
    
    //list of all faculties
    List<Faculty> faculties = new List<Faculty>();
    
    public void addNewFaculty(String facultyName, Integer studentCount, String website, Long phone) {
        Faculty faculty = new Faculty(facultyName, studentCount, website, phone);
        faculties.add(faculty);
    }
    
    public void getAllFaculties() {
        for (Faculty faculty: faculties) {
            System.debug('Faculty name:' + faculty.facultyName + 
                         ' Student count:' + faculty.studentCount + 
                         ' Website:' + faculty.website + 
                         ' Phone:' + faculty.phone);
        }
    }
    
    private class Faculty {
        public String facultyName;
        public Integer studentCount;
        public String website;
        public Long phone;
        
        Faculty(String facultyName, Integer studentCount, String website, Long phone) {
            this.facultyName = facultyName;
            this.studentCount = studentCount;
            this.website = website;
            this.phone = phone;
        }
    }
}