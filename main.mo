import Buffer "mo:base/Buffer";
import Text "mo:base/Text";
import Nat "mo:base/Nat";
import Time "mo:base/Time";

actor {
  type ApplicationId = Nat;
  
  type Application = {
    id : ApplicationId;
    company : Text;
    role : Text;
    status : Text;
    date : Time.Time;
  };

  var applications = Buffer.Buffer<Application>(0);

  public func addApplication(company : Text, role : Text, status : Text) : async ApplicationId {
    let applicationId = applications.size();
    let newApplication : Application = {
      id = applicationId;
      company = company;
      role = role;
      status = status;
      date = Time.now();
    };
    applications.add(newApplication);
    applicationId;
  };

  public query func getApplication(applicationId : ApplicationId) : async ?Application {
    if (applicationId < applications.size()) {
      ?applications.get(applicationId);
    } else {
      null;
    };
  };

  public func updateStatus(applicationId : ApplicationId, newStatus : Text) : async Bool {
    if (applicationId < applications.size()) {
      let application = applications.get(applicationId);
      let updatedApplication : Application = {
        id = application.id;
        company = application.company;
        role = application.role;
        status = newStatus;
        date = Time.now();
      };
      applications.put(applicationId, updatedApplication);
      true;
    } else {
      false;
    };
  };

  public query func getAllApplications() : async [Application] {
    Buffer.toArray(applications);
  };
};